Good Night Backend

## 📌 Description

Good Night Backend is a Ruby on Rails API service for sleep tracking, user management.

## Main features:
	•	Users can clock in/out sleep sessions
	•	Follow/unfollow other users
	•	View personal and social sleep histories

## Tech stack:
	•	PostgreSQL → primary database
	•	Redis → caching (user data, follow relationships)

## ⚙️ Requirements
	•	Ruby: 3.2.2
	•	Rails: 7.2.2.2
	•	PostgreSQL ≥ 13
	•	Redis ≥ 6

## 🚀 Setup
1. Clone the repository
  ```bash
    git clone https://github.com/arahmandanu/good-night-be.git
    cd good-night-be
  ```
2. Setup Env
  - copy env.example
  - rename to .env
  - update env value
3. Install dependencies
  ```bash
    bundle install
    bundle exec rails assets:precompile
  ```
4. Setup database
  ```bash
    bin/rails db:create
    bin/rails db:migrate
  ```
5. Run the server
  ```bash
    bin/rails server
    Server will be available at: http://localhost:3000
  ```
6. Grape API
  ```bash
    http://localhost:3000/swagger
  ```
## 🧪 Testing
  ```bash
    bundle exec rspec
  ```

## 🛠 Services
	•	Redis → caching user/follow data
	•	Sidekiq (optional) → background jobs (if you add later)
	•	Others → TBD

## Example Requests
1. Clock in sleep
```bash
  curl -X POST http://localhost:3000/api/v1/sleeps/clock_in \
  -H "Content-Type: application/json" \
  -d '{
    "user_id": "123e4567-e89b-12d3-a456-426614174000",
    "start_time": "2025-09-17T22:00:00Z"
  }'
```
2. Clock out sleep
```bash
  curl -X POST http://localhost:3000/api/v1/sleeps/clock_out \
  -H "Content-Type: application/json" \
  -d '{
    "user_id": "123e4567-e89b-12d3-a456-426614174000",
    "end_time": "2025-09-18T06:00:00Z"
  }'
```
3. Follow a user
```bash
  curl -X POST http://localhost:3000/api/v1/users/follow \
  -H "Content-Type: application/json" \
  -d '{
    "user_id": "123e4567-e89b-12d3-a456-426614174000",
    "followed_id": "987e6543-e21b-45d6-b789-123456789abc"
  }'
```
4. Get followed users’ sleep histories (last 7 days)
```bash
  curl -X GET "http://localhost:3000/api/v1/sleeps/histories?user_id=123e4567-e89b-12d3-a456-426614174000&start_date=2025-09-10&end_date=2025-09-17&page=1&per_page=10" \
  -H "Content-Type: application/json"
```
