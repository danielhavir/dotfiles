package main

import (
	"context"
	"crypto/rand"
	"flag"
	"fmt"
	"io"
	"log"
	"net/http"
	"os"
	"os/exec"
	"regexp"
	"syscall"

	"github.com/PuerkitoBio/goquery"
	"github.com/atotto/clipboard"
	"github.com/fatih/color"
	"github.com/go-redis/redis/v8"
	"golang.org/x/crypto/chacha20poly1305"
	"golang.org/x/term"
)

const nonceSize = 24

func check(e error) {
	if e != nil {
		log.Fatal(e)
	}
}

func readfile(path string) []byte {
	dat, err := os.ReadFile(path)
	check(err)
	return dat
}

func writefile(text []byte, path string) {
	err := os.WriteFile(path, text, 0664)
	check(err)
}

func openPage(url string) *http.Response {
	res, err := http.Get(url)
	check(err)
	return res
}

func getRandCommit() string {
	res := openPage("http://whatthecommit.com/")
	defer res.Body.Close()
	if res.StatusCode != 200 {
		log.Fatalf("status code error: %d %s", res.StatusCode, res.Status)
	}

	doc, err := goquery.NewDocumentFromReader(res.Body)
	check(err)

	s := doc.Find("#content").Find("p").First().Text()
	return s
}

func getIPAddress(prefix string) string {
	var url string

	if prefix == "ipv4" || prefix == "ipv6" {
		url = "https://" + prefix + ".icanhazip.com"
	} else {
		url = "https://icanhazip.com"
	}

	res := openPage(url)
	text, err := io.ReadAll(res.Body)
	check(err)
	return string(text)
}

func getLocalIPAddress() string {
	ifconfig, err := exec.Command("ifconfig", "wlp9s0").Output()
	check(err)

	// It ain't silly if it works
	ifconfig = regexp.MustCompile(`inet \d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}`).Find(ifconfig)
	ifconfig = regexp.MustCompile(`\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}`).Find(ifconfig)

	return string(ifconfig) + "\n"
}

func showCTypes() {
	bold := color.New(color.FgCyan, color.Bold)
	p := fmt.Println
	bold.Println("Data Type                  Memory (bytes)          Range                      Format Specifier")
	p("short int (int16)                2          -32,768 to 32,767                       %hd")
	p("unsigned short int (uint16)      2           0 to 65,535                            %hu")
	p("unsigned int (uint32)            4           0 to 4,294,967,295                     %u")
	p("int (int32)                      4          -2,147,483,648 to 2,147,483,647         %d")
	p("long int (int32)                 4          -2,147,483,648 to 2,147,483,647         %ld")
	p("unsigned long int (uint32)       4           0 to 4,294,967,295                     %lu")
	p("long long int (int64)            8          -(2^63) to (2^63)-1                     %lld")
	p("unsigned long long int (uint64)  8           0 to 18,446,744,073,709,551,615        %llu")
	p("signed char (int8)               1          -128 to 127                             %c")
	p("unsigned char (uint8)            1           0 to 255                               %c")
	p("float (float32)                  4                                                  %f")
	p("double (float64)                 8                                                  %lf")
	p("long double                    10-16                                                %Lf")

}

func getKey() (key []byte) {
	fmt.Print("Enter Password: ")
	key, err := term.ReadPassword(int(syscall.Stdin))
	check(err)
	if len(key) > 32 {
		key = key[:32]
	} else if len(key) < 32 {
		padded := make([]byte, 32)
		copy(padded[:len(key)], key)
		key = padded
	}
	fmt.Println()
	return
}

func encryptFile(plain, key []byte) (cipher []byte) {
	aead, err := chacha20poly1305.NewX(key)
	check(err)
	nonce := make([]byte, nonceSize)
	_, err = rand.Read(nonce)
	check(err)
	cipher = aead.Seal(nil, nonce, plain, nil)
	cipher = append(nonce, cipher...)
	return
}

func decryptFile(cipher, key []byte) (plain []byte) {
	aead, err := chacha20poly1305.NewX(key)
	check(err)
	nonce := cipher[:nonceSize]
	plain, err = aead.Open(nil, nonce, cipher[nonceSize:], nil)
	check(err)
	return
}

func getRedisClient() (rds *redis.Client) {
	addr := fmt.Sprintf("%s:%s", os.Getenv("REDIS_HOST"), os.Getenv("REDIS_PORT"))
	rds = redis.NewClient(&redis.Options{
		Addr:     addr,
		Password: os.Getenv("REDIS_PASSWORD"),
		DB:       0,
	})
	return
}

func push(text string, use_clip bool) {
	rds := getRedisClient()
	defer rds.Close()

	var err error
	if use_clip {
		text, err = clipboard.ReadAll()
		check(err)
	}

	err = rds.LPush(context.Background(), "clip", text).Err()
	check(err)
}

func pop(use_clip bool) {
	rds := getRedisClient()
	defer rds.Close()

	text := rds.LPop(context.Background(), "clip").Val()

	if use_clip {
		err := clipboard.WriteAll(text)
		check(err)
	} else {
		fmt.Print(text)
	}
}

func wipe() {
	rds := getRedisClient()
	defer rds.Close()

	err := rds.Del(context.Background(), "clip").Err()
	check(err)
}

func list() {
	rds := getRedisClient()
	defer rds.Close()

	result, err := rds.LRange(context.Background(), "clip", 0, -1).Result()
	check(err)
	for i, r := range result {
		fmt.Println(i, r)
	}
}

func get(i int64, use_clip bool) {
	rds := getRedisClient()
	defer rds.Close()

	text := rds.LIndex(context.Background(), "clip", i).Val()

	if use_clip {
		err := clipboard.WriteAll(text)
		check(err)
	} else {
		fmt.Print(text)
	}
}

func main() {
	ip := flag.Bool("ip", false, "Get public IP address")
	ipv4 := flag.Bool("ipv4", false, "Get public IPv4 address")
	ipv6 := flag.Bool("ipv6", false, "Get public IPv6 address")
	local := flag.Bool("local", false, "Get local IP address")
	ctypes := flag.Bool("ctypes", false, "Show C types")
	randCommit := flag.Bool("rc", false, "Get random commit")
	encrypt := flag.Bool("en", false, "Encrypt")
	decrypt := flag.Bool("de", false, "Decrypt")
	i := flag.Int64("i", 0, "Index")
	stdinFlag := flag.Bool("stdin", false, "Read input from STDIN for push command")
	text := flag.String("v", "", "Value")
	clipCmd := flag.Bool("clip", false, "Use clipboard")
	pushCmd := flag.Bool("push", false, "Push value to stack")
	popCmd := flag.Bool("pop", false, "Pop value from stack")
	wipeCmd := flag.Bool("wipe", false, "Delete all values from stack")
	listCmd := flag.Bool("list", false, "List all values in stack")
	getCmd := flag.Bool("get", false, "Get value at Index from stack")
	inputPath := flag.String("in", "", "Path to input file.")
	outputPath := flag.String("out", "", "Path to output file.")
	flag.Parse()

	var s string
	if *ip {
		s = getIPAddress("")
	} else if *ipv4 {
		s = getIPAddress("ipv4")
	} else if *ipv6 {
		s = getIPAddress("ipv6")
	} else if *randCommit {
		s = getRandCommit()
	} else if *local {
		s = getLocalIPAddress()
	} else if *ctypes {
		showCTypes()
	} else if *encrypt {
		plain := readfile(*inputPath)
		cipher := encryptFile(plain, getKey())
		writefile(cipher, *outputPath)
		s = "File " + *inputPath + " encrypted into " + *outputPath + "\n"
	} else if *decrypt {
		cipher := readfile(*inputPath)
		plain := decryptFile(cipher, getKey())
		writefile(plain, *outputPath)
		s = "File " + *inputPath + " decrypted into " + *outputPath + "\n"
	} else if *pushCmd {
		var input string
		if *stdinFlag {
			// Read piped input when -stdin is set
			bytes, err := io.ReadAll(os.Stdin)
			check(err)
			input = string(bytes)
		} else {
			input = *text
		}
		push(input, *clipCmd)
	} else if *popCmd {
		pop(*clipCmd)
	} else if *wipeCmd {
		wipe()
	} else if *listCmd {
		list()
	} else if *getCmd {
		get(*i, *clipCmd)
	}
	fmt.Print(s)
}
