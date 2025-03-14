package controllers

import (
	"eis-backend/database"
	"eis-backend/models"
	"net/http"

	"github.com/labstack/echo/v4"
)

// Get all financial data
func GetFinancials(c echo.Context) error {
	var financials []models.Financial
	if err := database.DB.Table("financial_reports").Find(&financials).Error; err != nil {
		return c.JSON(http.StatusInternalServerError, map[string]string{"error": err.Error()})
	}
	return c.JSON(http.StatusOK, financials)
}

// Create new financial data
func CreateFinancial(c echo.Context) error {
	financial := new(models.Financial)
	if err := c.Bind(financial); err != nil {
		return c.JSON(http.StatusBadRequest, map[string]string{"error": "Invalid request"})
	}

	if err := database.DB.Create(&financial).Error; err != nil {
		return c.JSON(http.StatusInternalServerError, map[string]string{"error": err.Error()})
	}

	return c.JSON(http.StatusCreated, financial)
}

// Delete financial data by ID
func DeleteFinancial(c echo.Context) error {
	id := c.Param("id")

	if err := database.DB.Delete(&models.Financial{}, id).Error; err != nil {
		return c.JSON(http.StatusInternalServerError, map[string]string{"error": err.Error()})
	}

	return c.JSON(http.StatusOK, map[string]string{"message": "Financial data deleted"})
}
