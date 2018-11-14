// From https://gowebexamples.com/templates/

package main

import (
	"html/template"
	"net/http"
	"time"
)

type Message struct {
	Text    string
	Hot     bool
	Created time.Time
}

type MessagePageData struct {
	PageTitle string
	Messages  []Message
}

func main() {
	tmpl := template.Must(template.ParseFiles("layout.html"))

	http.HandleFunc("/", func(w http.ResponseWriter, r *http.Request) {
		data := MessagePageData{
			PageTitle: "My messages",
			Messages: []Message{
				{Text: "Donec nec justo eget felis facilisis fermentum.", Hot: false, Created: time.Now()},
				{Text: "Aliquam porttitor mauris sit amet orci.", Hot: false, Created: time.Now()},
				{Text: "Aenean dignissim pellentesque felis.", Hot: true, Created: time.Now()},
				{Text: "Morbi in sem quis dui placerat ornare.", Hot: false, Created: time.Now()},
				{Text: "Pellentesque odio nisi, euismod in, pharetra a, ultricies in, diam.", Hot: true, Created: time.Now()},
				{Text: "Sed arcu. Cras consequat.", Hot: false, Created: time.Now()},
				{Text: "Praesent dapibus, neque id cursus faucibus.", Hot: true, Created: time.Now()},
				{Text: "Tortor neque egestas augue, eu vulputate magna eros eu erat.", Hot: false, Created: time.Now()},
				{Text: "Aliquam erat volutpat.", Hot: false, Created: time.Now()},
				{Text: "Nam dui mi, tincidunt quis, accumsan porttitor.", Hot: false, Created: time.Now()},
				{Text: "Dacilisis luctus, metus.", Hot: true, Created: time.Now()},
			},
		}
		tmpl.Execute(w, data)
	})

	http.ListenAndServe(":8080", nil)
}
