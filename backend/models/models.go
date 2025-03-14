package models

import "gorm.io/gorm"

type Employee struct {
	gorm.Model
	NIK          string  `json:"nik" gorm:"unique"`
	FullName     string  `json:"full_name"`
	Gender       string  `json:"gender"`
	BirthDate    string  `json:"birth_date"`
	HireDate     string  `json:"hire_date"`
	DepartmentID int     `json:"department_id"`
	PositionID   int     `json:"position_id"`
	Salary       float64 `json:"salary"`
	Email        string  `json:"email"`
	Phone        string  `json:"phone"`
	Status       string  `json:"status"`
}

type Department struct {
	ID   int    `json:"id"`
	Name string `json:"name"`
}

type Position struct {
	ID   int    `json:"id"`
	Name string `json:"name"`
}

type Financial struct {
	gorm.Model
	Revenue     float64 `json:"revenue"`
	Expenses    float64 `json:"expenses"`
	Profit      float64 `json:"profit"`
	Year        int     `json:"year"`
	Description string  `json:"description"`
	ReportType  string  `json:"report_type"` // Tambahkan ini

}
