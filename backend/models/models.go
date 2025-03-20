package models

import (
	"time"

	"gorm.io/gorm"
)

type Employee struct {
	gorm.Model
	NIK          string     `json:"nik" gorm:"unique"`
	FullName     string     `json:"full_name"`
	Gender       string     `json:"gender"`
	BirthDate    string     `json:"birth_date"`
	HireDate     string     `json:"hire_date"`
	Salary       float64    `json:"salary"`
	Email        string     `json:"email" gorm:"unique"` // Tidak perlu nama constraint manual
	Phone        string     `json:"phone"`
	Status       string     `json:"status"`
	DepartmentID int        `json:"department_id"`
	PositionID   int        `json:"position_id"`
	Department   Department `json:"department" gorm:"foreignKey:DepartmentID;references:ID"`
	Position     Position   `json:"position" gorm:"foreignKey:PositionID;references:ID"`
}

type Department struct {
	ID   int    `json:"id" gorm:"primaryKey;column:department_id"`
	Name string `json:"name" gorm:"column:department_name"`
}

type Position struct {
	ID   int    `json:"id" gorm:"primaryKey;column:position_id"`
	Name string `json:"name" gorm:"unique;column:position_name"`
}

type Financial struct {
	ReportID   uint       `json:"report_id" gorm:"primaryKey;autoIncrement"`
	ReportType string     `json:"report_type"`
	ReportDate time.Time  `json:"report_date"`
	Revenue    float64    `json:"revenue"`
	Expenses   float64    `json:"expenses"`
	NetProfit  float64    `json:"net_profit"`
	Assets     float64    `json:"assets"`
	CreatedAt  time.Time  `json:"created_at"`
	UpdatedAt  time.Time  `json:"updated_at"`
	DeletedAt  *time.Time `json:"deleted_at" gorm:"index"`
}

type Budget struct {
	BudgetID        uint       `json:"budget_id" gorm:"primaryKey;autoIncrement"`
	DepartmentID    uint       `json:"department_id"`
	BudgetYear      int        `json:"budget_year"`
	AllocatedBudget float64    `json:"allocated_budget"`
	UsedBudget      float64    `json:"used_budget"`
	Department      Department `json:"department" gorm:"foreignKey:DepartmentID;references:ID"`
}

// 🚀 **Pastikan GORM membaca tabel sebagai `financial_reports`**
func (Financial) TableName() string {
	return "financial_reports"
}

// 🚀 Pastikan GORM membaca tabel sebagai `budgets`
func (Budget) TableName() string {
	return "budgets"
}
