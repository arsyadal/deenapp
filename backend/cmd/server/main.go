package main

import (
	"log"
	"net/http"
	"os"

	"github.com/deenapp/backend/internal/handler"
	"github.com/deenapp/backend/internal/middleware"
	"github.com/deenapp/backend/internal/service"
	"github.com/go-chi/chi/v5"
	chimw "github.com/go-chi/chi/v5/middleware"
	"github.com/go-chi/cors"
)

func main() {
	jwtSecret := os.Getenv("SUPABASE_JWT_SECRET")
	if jwtSecret == "" {
		log.Fatal("SUPABASE_JWT_SECRET environment variable is required")
	}

	prayerService := service.NewPrayerService()
	zikirService := service.NewZikirService()

	prayerHandler := handler.NewPrayerHandler(prayerService)
	zikirHandler := handler.NewZikirHandler(zikirService)

	r := chi.NewRouter()

	r.Use(chimw.Logger)
	r.Use(chimw.Recoverer)
	r.Use(cors.Handler(cors.Options{
		AllowedOrigins:   []string{"*"},
		AllowedMethods:   []string{"GET", "POST", "PUT", "DELETE", "OPTIONS"},
		AllowedHeaders:   []string{"Accept", "Authorization", "Content-Type"},
		ExposedHeaders:   []string{"Link"},
		AllowCredentials: false,
		MaxAge:           300,
	}))

	r.Get("/health", func(w http.ResponseWriter, r *http.Request) {
		w.WriteHeader(http.StatusOK)
		w.Write([]byte(`{"status":"ok"}`))
	})

	r.Route("/api", func(r chi.Router) {
		r.Use(middleware.JWTAuth(jwtSecret))

		r.Get("/prayer/times", prayerHandler.GetPrayerTimes)

		r.Post("/zikir/log", zikirHandler.SaveLog)
		r.Get("/zikir/logs", zikirHandler.GetLogs)
		r.Get("/zikir/progress", zikirHandler.GetProgress)
	})

	log.Println("DeenApp backend starting on :8080")
	if err := http.ListenAndServe(":8080", r); err != nil {
		log.Fatalf("server failed: %v", err)
	}
}
