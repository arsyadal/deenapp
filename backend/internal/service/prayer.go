package service

import (
	"encoding/json"
	"fmt"
	"net/http"
	"time"

	"github.com/deenapp/backend/internal/model"
)

type PrayerService struct {
	client *http.Client
}

func NewPrayerService() *PrayerService {
	return &PrayerService{
		client: &http.Client{Timeout: 10 * time.Second},
	}
}

func (s *PrayerService) FetchPrayerTimes(lat, lng float64) ([]model.Prayer, error) {
	timestamp := time.Now().Unix()
	url := fmt.Sprintf(
		"https://api.aladhan.com/v1/timings/%d?latitude=%f&longitude=%f&method=2",
		timestamp, lat, lng,
	)

	resp, err := s.client.Get(url)
	if err != nil {
		return nil, fmt.Errorf("failed to fetch prayer times: %w", err)
	}
	defer resp.Body.Close()

	if resp.StatusCode != http.StatusOK {
		return nil, fmt.Errorf("aladhan API returned status %d", resp.StatusCode)
	}

	var apiResp model.PrayerTimesResponse
	if err := json.NewDecoder(resp.Body).Decode(&apiResp); err != nil {
		return nil, fmt.Errorf("failed to decode prayer times: %w", err)
	}

	timings := apiResp.Data.Timings
	prayers := []model.Prayer{
		{Name: "Fajr", ArabicName: "الفجر", Time: timings.Fajr},
		{Name: "Sunrise", ArabicName: "الشروق", Time: timings.Sunrise},
		{Name: "Dhuhr", ArabicName: "الظهر", Time: timings.Dhuhr},
		{Name: "Asr", ArabicName: "العصر", Time: timings.Asr},
		{Name: "Maghrib", ArabicName: "المغرب", Time: timings.Maghrib},
		{Name: "Isha", ArabicName: "العشاء", Time: timings.Isha},
	}

	return prayers, nil
}
