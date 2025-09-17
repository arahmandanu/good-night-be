Good Night Backend

## 📌 Description

Good Night Backend is a Ruby on Rails API service for sleep tracking, user management, and social features.

## Main features:
	•	Users can clock in/out sleep sessions
	•	Follow/unfollow other users
	•	View personal and social sleep histories

## Tech stack:
	•	PostgreSQL → primary database
	•	Redis → caching (user data, follow relationships)

## ⚙️ Requirements
	•	Ruby: 3.2.2 (your README says 3.22, I assume you mean 3.2.2?)
	•	Rails: (add your version, e.g., 7.1.x)
	•	PostgreSQL ≥ 13
	•	Redis ≥ 6

## 🚀 Setup
1. Clone the repository
  ```bash
    git clone https://github.com/arahmandanu/good-night-be.git
    cd good-night-be
  ```
2. Install dependencies
  ```bash
    bundle install
  ```
3. Setup database
  ```bash
    bin/rails db:create
    bin/rails db:migrate
  ```
4. Run the server
  ```bash
    bin/rails server
  ```
  Server will be available at: http://localhost:3000

## 🧪 Testing
```bash
  bundle exec rspec
```

## 🛠 Services
	•	Redis → caching user/follow data
	•	Sidekiq (optional) → background jobs (if you add later)
	•	Others → TBD
