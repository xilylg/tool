package conf

import (
	"flag"
	"goService/libs/config"
	"io/ioutil"

	"github.com/BurntSushi/toml"
)

type Config struct {
	Addr string
}

var (
	confPath string
	Conf     Config
)

func init() {
	flag.StringVar(&confPath, "conf", "./cmd/conf.toml", "default config path")
}

func Init() error {
	return config.Xtoml(confPath, &Conf)
}

func Xtoml(path string, c interface{}) (err error) {
	var blob []byte
	if blob, err = ioutil.ReadFile(path); err != nil {
		return err
	}

	_, err = toml.Decode(string(blob), c)
	return
}
