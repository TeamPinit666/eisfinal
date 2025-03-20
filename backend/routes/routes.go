package routes

import (
	"eis-backend/controllers"

	"github.com/labstack/echo/v4"
)

func InitRoutes(e *echo.Echo) {
	api := e.Group("/api") // Group API dengan prefix /api

	api.GET("/employees", controllers.GetEmployees)
	api.POST("/employees", controllers.CreateEmployee)
	api.DELETE("/employees/:id", controllers.DeleteEmployee)

	api.GET("/financials", controllers.GetFinancials)
	api.POST("/financials", controllers.CreateFinancial)
	api.DELETE("/financials/:id", controllers.DeleteFinancial)

	api.GET("/budgets", controllers.GetBudgets)
	api.POST("/financials", controllers.CreateBudget)
	api.DELETE("/financials/:id", controllers.DeleteBudget)
}
