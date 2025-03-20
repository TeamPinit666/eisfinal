package controllers

import (
	"eis-backend/database"
	"eis-backend/models"
	"net/http"
	"strconv"
	"time"

	"github.com/labstack/echo/v4"
)

// Get all financial reports
func GetFinancials(c echo.Context) error {
	var financials []models.Financial

	// Fetch pagination params
	page, _ := strconv.Atoi(c.QueryParam("page"))
	limit, _ := strconv.Atoi(c.QueryParam("limit"))

	// Default pagination values
	if page <= 0 {
		page = 1
	}
	if limit <= 0 {
		limit = 10
	}

	offset := (page - 1) * limit

	// ✅ **Pastikan query menggunakan `financial_reports`**
	if err := database.DB.Table("financial_reports").
		Where("deleted_at IS NULL").
		Order("report_date DESC").
		Offset(offset).
		Limit(limit).
		Find(&financials).Error; err != nil {
		return c.JSON(http.StatusInternalServerError, map[string]string{"error": err.Error()})
	}

	return c.JSON(http.StatusOK, financials)
}

// Create new financial report
func CreateFinancial(c echo.Context) error {
	var financial models.Financial
	if err := c.Bind(&financial); err != nil {
		return c.JSON(http.StatusBadRequest, map[string]string{"error": "Invalid request"})
	}

	// Auto-calculate net profit (revenue - expenses)
	financial.NetProfit = financial.Revenue - financial.Expenses

	// ✅ **Pastikan menyimpan ke tabel `financial_reports`**
	if err := database.DB.Table("financial_reports").Create(&financial).Error; err != nil {
		return c.JSON(http.StatusInternalServerError, map[string]string{"error": err.Error()})
	}

	return c.JSON(http.StatusCreated, financial)
}

// Soft delete financial report
func DeleteFinancial(c echo.Context) error {
	id := c.Param("id")

	// ✅ **Gunakan tabel `financial_reports`**
	if err := database.DB.Table("financial_reports").
		Where("report_id = ?", id).
		Update("deleted_at", time.Now()).Error; err != nil {
		return c.JSON(http.StatusInternalServerError, map[string]string{"error": err.Error()})
	}

	return c.JSON(http.StatusOK, map[string]string{"message": "Financial report deleted"})
}
