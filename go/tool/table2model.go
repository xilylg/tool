package main

import (
	"database/sql"
	"flag"
	"fmt"
	"io/ioutil"
	"strings"

	_ "github.com/go-sql-driver/mysql"
	"github.com/jmoiron/sqlx"
)

var table, file, h string
var err error
var database *sqlx.DB

func init() {
	database, err = sqlx.Open("mysql", "root:123456@tcp(127.0.0.1:3306)/example")
	if err != nil {
		panic(err)
	}

	flag.StringVar(&table, "table", "", "tablename, multi table split ','")
	flag.StringVar(&file, "file", "", "to filename")
	flag.StringVar(&h, "h", "", "show help")
	flag.Parse()
}

func main() {
	if h != "" {
		showHelp()
		return
	}
	var modelStr string
	if table == "" {
		table = allTables()
	}
	tables := strings.Split(table, ",")
	for _, v := range tables {
		modelStr += table2Model(v)
		modelStr += "\n\n"
	}

	var result = []byte(modelStr)
	err := ioutil.WriteFile(file, result, 0666) //写入文件(字节数组)
	if err != nil {
		panic(err)
	}
	fmt.Println("OK")
}

func showHelp() {
	str := `
	1.修改代码里的数据库连接信息
	2. go run main.go  -table="表名" -file="生成文件名,多个用,隔开"
	3. 如果要全库表生成，修改相关代码
	`
	fmt.Println(str)
}

type dbTable struct {
	Table string `db:"Tables_in_account_book"` // 修改这里的Tables_in_account_book
}

func allTables() string {
	var tables []dbTable
	err = database.Select(&tables, "show tables")
	if err != nil {
		panic(err)
	}

	var result string
	for _, v := range tables {
		result += v.Table + ","
	}
	return strings.Trim(result, ",")
}

type column struct {
	Field   string         `db:"Field"`
	Type    string         `db:"Type"`
	Null    string         `db:"Null"`
	Key     string         `db:"Key"`
	Default sql.NullString `db:"Default"`
	Extra   string         `db:"Extra"`
}

func table2Model(table string) string {
	result := "type " + camelCase(table) + " struct {\n"
	var cols []column

	err = database.Select(&cols, "show columns from "+table)
	if err != nil {
		panic(err)
	}

	for _, col := range cols {
		result += fmt.Sprintf("    %s  %s    `db:\"%s\"`\n", camelCase(col.Field), getSqlType(col.Type), col.Field)
	}

	result += "}"
	return result
}

func camelCase(s string) string {
	var result string
	strs := strings.Split(s, "_")
	for _, v := range strs {
		result += strings.Title(v)
	}
	return result
}

func getSqlType(t string) string {
	switch t {
	case "bigint":
		return "int64"
	case "int":
		return "int"
	case "tinyint":
		return "int8"
	default:
		if strings.Contains(t, "varchar") {
			return "string"
		}
	}
	return ""
}
