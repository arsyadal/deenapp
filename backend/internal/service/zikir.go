package service

import (
	"fmt"
	"sync"
	"time"

	"github.com/deenapp/backend/internal/model"
)

type ZikirService struct {
	mu   sync.RWMutex
	logs map[string][]model.ZikirLog
}

func NewZikirService() *ZikirService {
	return &ZikirService{
		logs: make(map[string][]model.ZikirLog),
	}
}

func (s *ZikirService) SaveLog(userID string, log model.ZikirLog) model.ZikirLog {
	s.mu.Lock()
	defer s.mu.Unlock()

	log.UserID = userID
	log.ID = fmt.Sprintf("%d", time.Now().UnixNano())
	log.CreatedAt = time.Now().UTC().Format(time.RFC3339)
	log.Completed = log.Count >= log.Target

	s.logs[userID] = append(s.logs[userID], log)
	return log
}

func (s *ZikirService) GetLogs(userID string, date string) []model.ZikirLog {
	s.mu.RLock()
	defer s.mu.RUnlock()

	allLogs := s.logs[userID]
	if allLogs == nil {
		return []model.ZikirLog{}
	}

	if date == "" {
		date = time.Now().UTC().Format("2006-01-02")
	}

	var filtered []model.ZikirLog
	for _, l := range allLogs {
		t, err := time.Parse(time.RFC3339, l.CreatedAt)
		if err != nil {
			continue
		}
		if t.Format("2006-01-02") == date {
			filtered = append(filtered, l)
		}
	}

	if filtered == nil {
		return []model.ZikirLog{}
	}
	return filtered
}

type ZikirProgress struct {
	TotalLogs     int `json:"total_logs"`
	TotalCount    int `json:"total_count"`
	CompletedLogs int `json:"completed_logs"`
}

func (s *ZikirService) GetTodayProgress(userID string) ZikirProgress {
	todayLogs := s.GetLogs(userID, "")

	progress := ZikirProgress{}
	progress.TotalLogs = len(todayLogs)
	for _, l := range todayLogs {
		progress.TotalCount += l.Count
		if l.Completed {
			progress.CompletedLogs++
		}
	}
	return progress
}
