# Christ Student

Modern Flutter app for Christ University students with Supabase backend.

## Features

- 🔐 **Authentication**: Login with Register No and Password
- 📊 **Attendance Tracking**: View overall and subject-wise attendance with color coding
- 📝 **Marks Card**: Semester-wise marks with CIA breakdowns
- 📅 **Timetable**: Weekly schedule with day navigation
- 👤 **Profile**: Student information and settings
- 🎨 **Modern UI**: Material 3 design with Poppins typography

## Tech Stack

- **Frontend**: Flutter with Material 3
- **State Management**: Riverpod
- **Backend**: Supabase (PostgreSQL + Auth)
- **Routing**: go_router
- **Models**: Freezed + JSON serialization
- **UI**: Google Fonts (Poppins), percent_indicator

## Setup

### 1. Prerequisites

- Flutter SDK (latest stable)
- Git (for code generation)
- Supabase account

### 2. Supabase Setup

1. Create a new Supabase project
2. Go to SQL Editor and run the schema:

```sql
-- 1) Profiles
create table public.profiles (
  id uuid primary key references auth.users(id) on delete cascade,
  reg_no text unique not null,
  name text not null,
  program text,
  semester int,
  email text,
  created_at timestamptz default now()
);

-- 2) Attendance (per subject)
create table public.attendance (
  id bigserial primary key,
  user_id uuid references auth.users(id) on delete cascade,
  subject_code text not null,
  subject_name text not null,
  total_classes int not null default 0,
  attended_classes int not null default 0,
  updated_at timestamptz default now()
);

-- 3) Marks
create table public.marks (
  id bigserial primary key,
  user_id uuid references auth.users(id) on delete cascade,
  semester int not null,
  subject text not null,
  cia1 numeric,
  cia2 numeric,
  cia3 numeric,
  internal numeric,
  external numeric,
  total numeric,
  grade text,
  updated_at timestamptz default now()
);

-- 4) Timetable
create table public.timetable (
  id bigserial primary key,
  user_id uuid references auth.users(id) on delete cascade,
  day_of_week int not null check (day_of_week between 1 and 7),
  start_time time not null,
  end_time time not null,
  subject text not null,
  room text,
  faculty text
);

-- 5) Announcements (global)
create table public.announcements (
  id bigserial primary key,
  title text not null,
  body text,
  date date not null default current_date
);

-- Row Level Security
alter table public.profiles enable row level security;
alter table public.attendance enable row level security;
alter table public.marks enable row level security;
alter table public.timetable enable row level security;
alter table public.announcements enable row level security;

-- Policies: only owner can read/write their data
create policy "own profile" on public.profiles
  for select using (auth.uid() = id);
create policy "own profile write" on public.profiles
  for update using (auth.uid() = id);

create policy "own attendance" on public.attendance
  for select using (auth.uid() = user_id);
create policy "own attendance write" on public.attendance
  for insert with check (auth.uid() = user_id)
  using (auth.uid() = user_id);

create policy "own marks" on public.marks
  for select using (auth.uid() = user_id);
create policy "own marks write" on public.marks
  for insert with check (auth.uid() = user_id)
  using (auth.uid() = user_id);

create policy "own timetable" on public.timetable
  for select using (auth.uid() = user_id);
create policy "own timetable write" on public.timetable
  for insert with check (auth.uid() = user_id)
  using (auth.uid() = user_id);

-- Announcements: readable by all authenticated users
create policy "read announcements" on public.announcements
  for select using (auth.role() = 'authenticated');
```

3. Copy your project URL and anon key from Settings > API

### 3. Flutter Setup

1. Clone and install dependencies:
```bash
git clone <your-repo>
cd christ_student
flutter pub get
```

2. Create environment file:
```bash
cp env.example .env
# Edit .env with your Supabase credentials
```

3. Run code generation (requires Git):
```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

4. Run the app:
```bash
# With environment variables
flutter run --dart-define=SUPABASE_URL=YOUR_URL --dart-define=SUPABASE_ANON_KEY=YOUR_KEY

# Or load from .env file (if using flutter_dotenv)
flutter run
```

## Project Structure

```
lib/
├── app/
│   ├── router.dart          # GoRouter configuration
│   └── theme.dart           # App theme and colors
├── data/
│   ├── api/
│   │   └── client.dart      # Supabase client
│   └── models/              # Freezed data models
├── features/
│   ├── auth/                # Login screen
│   ├── home/                # Dashboard
│   ├── attendance/          # Attendance tracking
│   ├── marks/               # Marks card
│   ├── timetable/           # Schedule
│   ├── profile/             # User profile
│   └── settings/            # App settings
├── repo/                    # Data repositories
└── features/common/
    └── providers.dart       # Riverpod providers
```

## Authentication Flow

1. Student enters Register No and Password
2. App converts Register No to email: `<regNo>@christ.in`
3. Supabase Auth validates credentials
4. On success, user is redirected to home screen
5. Session persists across app restarts

## Development

### Adding New Features

1. Create models in `data/models/`
2. Add repository methods in `repo/`
3. Create providers in `features/common/providers.dart`
4. Build UI screens in `features/`

### Code Generation

After modifying Freezed models:
```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

## Troubleshooting

- **Git not found**: Install Git and add to PATH
- **Build errors**: Run `flutter clean && flutter pub get`
- **Supabase connection**: Verify URL and anon key in environment
- **Code generation**: Ensure all imports are correct in model files

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test thoroughly
5. Submit a pull request

## License

This project is for educational purposes at Christ University.
