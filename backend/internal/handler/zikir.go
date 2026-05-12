package handler

import (
	"encoding/json"
	"net/http"

	"github.com/deenapp/backend/internal/middleware"
	"github.com/deenapp/backend/internal/model"
	"github.com/deenapp/backend/internal/service"
)

type ZikirHandler struct {
	service *service.ZikirService
}

func NewZikirHandler(s *service.ZikirService) *ZikirHandler {
	return &ZikirHandler{service: s}
}

func (h *ZikirHandler) SaveLog(w http.ResponseWriter, r *http.Request) {
	userID := middleware.GetUserID(r.Context())
	if userID == "" {
		http.Error(w, `{"error":"unauthorized"}`, http.StatusUnauthorized)
		return
	}

	var log model.ZikirLog
	if err := json.NewDecoder(r.Body).Decode(&log); err != nil {
		http.Error(w, `{"error":"invalid request body"}`, http.StatusBadRequest)
		return
	}

	saved := h.service.SaveLog(userID, log)

	w.Header().Set("Content-Type", "application/json")
	w.WriteHeader(http.StatusCreated)
	json.NewEncoder(w).Encode(saved)
}

func (h *ZikirHandler) GetLogs(w http.ResponseWriter, r *http.Request) {
	userID := middleware.GetUserID(r.Context())
	if userID == "" {
		http.Error(w, `{"error":"unauthorized"}`, http.StatusUnauthorized)
		return
	}

	date := r.URL.Query().Get("date")
	logs := h.service.GetLogs(userID, date)

	w.Header().Set("Content-Type", "application/json")
	json.NewEncoder(w).Encode(map[string]interface{}{
		"logs": logs,
	})
}

func (h *ZikirHandler) GetProgress(w http.ResponseWriter, r *http.Request) {
	userID := middleware.GetUserID(r.Context())
	if userID == "" {
		http.Error(w, `{"error":"unauthorized"}`, http.StatusUnauthorized)
		return
	}

	progress := h.service.GetTodayProgress(userID)

	w.Header().Set("Content-Type", "application/json")
	json.NewEncoder(w).Encode(progress)
}
