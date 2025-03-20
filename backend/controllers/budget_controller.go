package controllers

import (
	"eis-backend/database"
	"eis-backend/models"
	"net/http"

	"github.com/labstack/echo/v4"
)

// Get all budgets
func GetBudgets(c echo.Context) error {
	var budgets []models.Budget

	// Ambil tahun dari query parameter, jika ada
	year := c.QueryParam("year")

	query := database.DB.Table("budgets").Preload("Department")

	// Jika ada filter berdasarkan tahun
	if year != "" {
		query = query.Where("budget_year = ?", year)
	}

	// Jalankan query
	if err := query.Find(&budgets).Error; err != nil {
		return c.JSON(http.StatusInternalServerError, map[string]string{"error": err.Error()})
	}

	return c.JSON(http.StatusOK, budgets)
}

// Create new budget
func CreateBudget(c echo.Context) error {
	var budget models.Budget
	if err := c.Bind(&budget); err != nil {
		return c.JSON(http.StatusBadRequest, map[string]string{"error": "Invalid request"})
	}

	// Simpan data ke tabel `budgets`
	if err := database.DB.Table("budgets").Create(&budget).Error; err != nil {
		return c.JSON(http.StatusInternalServerError, map[string]string{"error": err.Error()})
	}

	return c.JSON(http.StatusCreated, budget)
}

// Delete budget
func DeleteBudget(c echo.Context) error {
	id := c.Param("id")

	if err := database.DB.Table("budgets").
		Where("budget_id = ?", id).
		Delete(&models.Budget{}).Error; err != nil {
		return c.JSON(http.StatusInternalServerError, map[string]string{"error": err.Error()})
	}

	return c.JSON(http.StatusOK, map[string]string{"message": "Budget deleted"})
}
