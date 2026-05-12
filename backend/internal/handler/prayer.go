package handler

import (
	"encoding/json"
	"net/http"
	"strconv"

	"github.com/deenapp/backend/internal/service"
)

type PrayerHandler struct {
	service *service.PrayerService
}

func NewPrayerHandler(s *service.PrayerService) *PrayerHandler {
	return &PrayerHandler{service: s}
}

func (h *PrayerHandler) GetPrayerTimes(w http.ResponseWriter, r *http.Request) {
	latStr := r.URL.Query().Get("lat")
	lngStr := r.URL.Query().Get("lng")

	if latStr == "" || lngStr == "" {
		http.Error(w, `{"error":"lat and lng query parameters are required"}`, http.StatusBadRequest)
		return
	}

	lat, err := strconv.ParseFloat(latStr, 64)
	if err != nil {
		http.Error(w, `{"error":"invalid lat parameter"}`, http.StatusBadRequest)
		return
	}

	lng, err := strconv.ParseFloat(lngStr, 64)
	if err != nil {
		http.Error(w, `{"error":"invalid lng parameter"}`, http.StatusBadRequest)
		return
	}

	prayers, err := h.service.FetchPrayerTimes(lat, lng)
	if err != nil {
		http.Error(w, `{"error":"failed to fetch prayer times"}`, http.StatusInternalServerError)
		return
	}

	w.Header().Set("Content-Type", "application/json")
	json.NewEncoder(w).Encode(map[string]interface{}{
		"prayers": prayers,
	})
}
