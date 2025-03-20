package main

import (
	"eis-backend/database"
	"eis-backend/models"
	"eis-backend/routes"
	"fmt"

	"github.com/labstack/echo/v4"
	"github.com/labstack/echo/v4/middleware"
)

func main() {
	e := echo.New()

	// 🔥 Konfigurasi CORS
	e.Use(middleware.CORSWithConfig(middleware.CORSConfig{
		AllowOrigins: []string{"http://localhost:5173"},
		AllowMethods: []string{echo.GET, echo.POST, echo.PUT, echo.DELETE},
		AllowHeaders: []string{echo.HeaderOrigin, echo.HeaderContentType, echo.HeaderAccept},
	}))

	// Koneksi ke database
	database.ConnectDB()

	// 🔥 Nonaktifkan penghapusan constraint otomatis
	database.DB.DisableForeignKeyConstraintWhenMigrating = true

	// 🔥 Jalankan migrasi ulang
	fmt.Println("Menjalankan migrasi database...")
	err := database.DB.AutoMigrate(
		&models.Department{},
		&models.Position{},
		&models.Employee{},
		&models.Financial{},
		&models.Budget{},
	)
	if err != nil {
		fmt.Println("❌ Gagal migrasi database:", err)
	} else {
		fmt.Println("✅ Migrasi database sukses!")
	}

	// Initialize Routes
	routes.InitRoutes(e)

	// Start Server
	e.Logger.Fatal(e.Start(":8080"))
}
