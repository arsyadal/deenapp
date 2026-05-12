package model

type Prayer struct {
	Name       string `json:"name"`
	ArabicName string `json:"arabic_name"`
	Time       string `json:"time"`
}

type PrayerTimesResponse struct {
	Code   int    `json:"code"`
	Status string `json:"status"`
	Data   struct {
		Timings struct {
			Fajr    string `json:"Fajr"`
			Sunrise string `json:"Sunrise"`
			Dhuhr   string `json:"Dhuhr"`
			Asr     string `json:"Asr"`
			Maghrib string `json:"Maghrib"`
			Isha    string `json:"Isha"`
		} `json:"timings"`
		Date struct {
			Readable  string `json:"readable"`
			Timestamp string `json:"timestamp"`
			Hijri     struct {
				Date    string `json:"date"`
				Day     string `json:"day"`
				Month   struct {
					Number int    `json:"number"`
					En     string `json:"en"`
					Ar     string `json:"ar"`
				} `json:"month"`
				Year string `json:"year"`
			} `json:"hijri"`
			Gregorian struct {
				Date  string `json:"date"`
				Day   string `json:"day"`
				Month struct {
					Number int    `json:"number"`
					En     string `json:"en"`
				} `json:"month"`
				Year string `json:"year"`
			} `json:"gregorian"`
		} `json:"date"`
	} `json:"data"`
}
