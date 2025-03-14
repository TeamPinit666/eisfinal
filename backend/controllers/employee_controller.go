package controllers

import (
	"eis-backend/database"
	"eis-backend/models"
	"net/http"

	"github.com/labstack/echo/v4"
)

// Get all employees
func GetEmployees(c echo.Context) error {
	var employees []models.Employee
	if err := database.DB.Find(&employees).Error; err != nil {
		return c.JSON(http.StatusInternalServerError, map[string]string{"error": err.Error()})
	}
	return c.JSON(http.StatusOK, employees)
}

// Create new employee
func CreateEmployee(c echo.Context) error {
	emp := new(models.Employee)
	if err := c.Bind(emp); err != nil {
		return c.JSON(http.StatusBadRequest, map[string]string{"error": "Invalid request"})
	}

	if err := database.DB.Create(&emp).Error; err != nil {
		return c.JSON(http.StatusInternalServerError, map[string]string{"error": err.Error()})
	}

	return c.JSON(http.StatusCreated, emp)
}

// Delete employee by ID
func DeleteEmployee(c echo.Context) error {
	id := c.Param("id")
	if err := database.DB.Delete(&models.Employee{}, id).Error; err != nil {
		return c.JSON(http.StatusInternalServerError, map[string]string{"error": err.Error()})
	}
	return c.JSON(http.StatusOK, map[string]string{"message": "Employee deleted successfully"})
}
	