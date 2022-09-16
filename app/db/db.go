package db

import (
	"database/sql"
	_ "github.com/lib/pq"
	"math/rand"
	"os"
	"time"
)

func init() {
	rand.Seed(time.Now().UnixNano())
}

func connect() (*sql.DB, error) {
	dbUrl := os.Getenv("DB_URL")
	db, err := sql.Open("postgres", dbUrl)
	return db, err
}

var letterRunes = []rune("abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ")

func randomData(n int) string {
	b := make([]rune, n)
	for i := range b {
		b[i] = letterRunes[rand.Intn(len(letterRunes))]
	}
	return string(b)
}

// Ping - check if DB is reachable
func Ping() error {
	db, err := connect()
	if err != nil {
		return err
	}
	defer db.Close()
	return db.Ping()
}

// Insert - insert random data to DB
func Insert() error {
	db, err := connect()
	if err != nil {
		return err
	}
	defer db.Close()

	_, err = db.Exec(`
		CREATE TABLE IF NOT EXISTS data (
		  id VARCHAR(20),
		  value TEXT,
		  PRIMARY KEY( id )
		);
	`)

	if err != nil {
		return err
	}

	insert := `insert into "data"("id", "value") values($1, $2)`
	_, err = db.Exec(insert, randomData(10), randomData(100))

	if err != nil {
		return err
	}

	return nil
}
