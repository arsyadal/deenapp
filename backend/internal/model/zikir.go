package model

type ZikirLog struct {
	ID        string `json:"id"`
	UserID    string `json:"user_id"`
	Type      string `json:"type"`
	ZikirName string `json:"zikir_name"`
	Count     int    `json:"count"`
	Target    int    `json:"target"`
	Completed bool   `json:"completed"`
	CreatedAt string `json:"created_at"`
}
