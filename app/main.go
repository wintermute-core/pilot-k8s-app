package main

import (
	"encoding/json"
	"fmt"
	"github.com/gofiber/fiber/v2"
	"k8s-app/db"
	"log"
	"os"
)

func main() {
	app := fiber.New()

	app.Get("/", rootHandler)
	app.Get("/health", healthHandler)

	app.Post("/insert", insertHandler)
	app.Get("/select", selectHandler)

	port := os.Getenv("PORT")
	if port == "" {
		port = "8000"
	}
	log.Fatalln(app.Listen(fmt.Sprintf(":%v", port)))
}

func rootHandler(c *fiber.Ctx) error {
	return c.SendString("Application index query /insert /select for DB operations")
}

func insertHandler(c *fiber.Ctx) error {
	err := db.Insert()
	if err != nil {
		return err
	}
	return c.SendString("Test data inserted")
}

func selectHandler(c *fiber.Ctx) error {
	output, err := db.Select()
	if err != nil {
		return err
	}
	js, err := json.Marshal(output)
	if err != nil {
		return err
	}
	return c.Send(js)
}

func healthHandler(c *fiber.Ctx) error {
	err := db.Ping()
	if err != nil {
		log.Printf("%w", err)
	}
	return err
}
