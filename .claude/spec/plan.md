Perfect! 🎯 Here's the **ULTIMATE DETAILED PLAN** - everything Claude Code needs to build your app from scratch!

---

# 📋 **COMPLETE FLUTTER PROJECT BLUEPRINT**

---

## **🎯 PROJECT IDENTITY**

```yaml
Project Name: learning_app
Package: com.khebach.learning_app
Description: Duolingo-style interactive learning app for Algerian students
Version: 1.0.0
Target SDK: Flutter 3.16+ / Dart 3.2+
Platforms: Android, iOS, Web
Primary Language: Arabic (RTL)
Design Style: Duolingo-inspired gamified islands
```

---

## **📁 PROJECT STRUCTURE**

```
learning_app/
├── lib/
│   ├── main.dart
│   ├── screens/
│   │   ├── home_screen.dart
│   │   ├── lessons_screen.dart
│   │   ├── profile_screen.dart
│   │   ├── quiz_screen.dart
│   │   └── results_screen.dart
│   ├── widgets/
│   │   ├── subject_card.dart
│   │   ├── lesson_island.dart
│   │   ├── stat_card.dart
│   │   ├── achievement_badge.dart
│   │   ├── bottom_nav_bar.dart
│   │   └── curved_path_painter.dart
│   ├── models/
│   │   ├── subject.dart
│   │   ├── lesson.dart
│   │   ├── question.dart
│   │   ├── user.dart
│   │   └── achievement.dart
│   ├── providers/
│   │   ├── theme_provider.dart
│   │   ├── user_provider.dart
│   │   └── progress_provider.dart
│   ├── services/
│   │   ├── storage_service.dart
│   │   └── audio_service.dart
│   ├── theme/
│   │   ├── app_theme.dart
│   │   └── app_colors.dart
│   └── utils/
│       ├── constants.dart
│       └── helpers.dart
├── assets/
│   ├── images/
│   ├── icons/
│   └── sounds/
├── pubspec.yaml
└── README.md
```

---

## **📦 DEPENDENCIES (pubspec.yaml)**

```yaml
dependencies:
  flutter:
    sdk: flutter
  
  # State Management
  provider: ^6.1.1
  
  # Local Storage
  shared_preferences: ^2.2.2
  
  # UI & Animations
  google_fonts: ^6.1.0
  animate_do: ^3.1.2
  flutter_animate: ^4.3.0
  
  # SVG & Icons
  flutter_svg: ^2.0.9
  
  # Audio
  audioplayers: ^5.2.1
  
  # Utils
  intl: ^0.18.1

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^3.0.0

flutter:
  uses-material-design: true
  assets:
    - assets/images/
    - assets/icons/
    - assets/sounds/
```

---

## **🎨 DESIGN SYSTEM**

### **Colors:**
```dart
// app_colors.dart
class AppColors {
  // Primary
  static const blue = Color(0xFF3B82F6);
  static const purple = Color(0xFF9333EA);
  static const pink = Color(0xFFEC4899);
  
  // Success/Progress
  static const green = Color(0xFF10B981);
  static const emerald = Color(0xFF059669);
  
  // Warning/Streak
  static const orange = Color(0xFFF97316);
  static const amber = Color(0xFFFBBF24);
  
  // Neutral Dark Mode
  static const slate900 = Color(0xFF0F172A);
  static const slate800 = Color(0xFF1E293B);
  static const slate700 = Color(0xFF334155);
  
  // Neutral Light Mode
  static const sky50 = Color(0xFFF0F9FF);
  static const blue50 = Color(0xFFEFF6FF);
  static const purple50 = Color(0xFFFAF5FF);
}
```

### **Typography:**
```dart
// Use Google Fonts
Primary Font: Cairo (Arabic-friendly)
Weights: 400 (regular), 600 (semibold), 700 (bold), 900 (black)
```

### **Theme:**
```dart
// Dark Mode
Background: Gradient from slate900 → indigo900 → slate900
Cards: slate800
Text: white

// Light Mode
Background: Gradient from sky50 → blue50 → purple50
Cards: white
Text: slate900
```

---

## **📱 SCREEN SPECIFICATIONS**

### **1. HOME SCREEN**

**Layout:**
```
┌─────────────────────────────────────┐
│  ✏️ 555        👤 ☀️/🌙      🔥 3   │  Header
├─────────────────────────────────────┤
│  👨‍🎓  أهلاً بك يا خباش أحمد        │  Welcome
│      استمر في التعلم...             │
├─────────────────────────────────────┤
│  🎯 45    ⭐ 128    🏆 8           │  Stats Cards
├─────────────────────────────────────┤
│  المواد الدراسية                    │  Title
├─────────────────────────────────────┤
│  ┌──────┐  ┌──────┐  ┌──────┐     │
│  │ 📖  │  │ 🌍  │  │ 📜  │     │  Subject
│  │عربي │  │جغرافيا│  │تاريخ │     │  Grid
│  │ 80% │  │ 50% │  │ 60% │     │  (2 cols)
│  └──────┘  └──────┘  └──────┘     │
│  [... 5 more subjects ...]         │
├─────────────────────────────────────┤
│  📖  🏆  💡  🚩  🏠               │  Bottom Nav
└─────────────────────────────────────┘
```

**Components:**
- **Stats Cards (3):** Completed lessons, Stars, Achievements
- **Subject Cards (8):**
  - Icon (emoji 3xl)
  - Name (text-xl bold)
  - Progress: "20/25 درس"
  - Progress bar (animated)
  - Border: 4px colored + shadow
  - Hover: scale(1.05)

**8 Subjects:**
1. لغة عربية 📖 - Green gradient - 80% (20/25)
2. جغرافيا 🌍 - Blue gradient - 50% (10/20)
3. تاريخ 📜 - Yellow gradient - 60% (18/30)
4. تربية مدنية 🤝 - Purple gradient - 25% (4/15)
5. تربية إسلامية 🕌 - Teal gradient - 30% (6/20)
6. علوم 🔬 - Pink gradient - 15% (5/35)
7. فرنسية 🗼 - Indigo gradient - 10% (4/40)
8. إنجليزية 🔤 - Red gradient - 10% (4/40)

---

### **2. LESSONS SCREEN (Duolingo Islands Style)**

**Header:**
```
← رجوع    ☀️/🌙  ✏️555  🔥3
```

**Subject Banner:**
```
┌─────────────────────────────────────┐
│  📜 تاريخ                      📜  │  Gradient
│  18/30 درس مكتمل                   │  Banner
│  [المستوى 1] [⭐ 45/50]            │
└─────────────────────────────────────┘
```

**Lesson Path (Vertical scroll):**
```
                    [🏆]  ← Trophy (locked)
                      │
                      │ (dashed line)
                      │
            [💡]  ← Lesson (unlocked)
              │ curved
              │ path
          [💪]  ← Practice (current - pulsing)
            │
            │
        [📝]  ← Quiz (completed ✓✓✓)
          │
          │
      [📚]  ← Lesson (completed ✓✓✓)
        │
        │
    [📚]  ← Lesson (completed ✓✓✓)
      │
      │
  [👨‍🎓]  ← User avatar (start)
```

**Island Specifications:**

**Position Pattern:** Right → Center → Left → Right... (zigzag)

**Lesson Types:**
- `lesson` 📚 - Regular lesson - Purple/Blue gradient
- `quiz` 📝 - Assessment - Blue badge
- `practice` 💪 - Review - Purple badge  
- `boss` 👑 - Challenge - Red badge + larger size
- `trophy` 🏆 - Achievement - Gold gradient

**Island States:**
- **Completed:** Green gradient + ✓ + 3 stars badge + ring
- **Current:** Blue gradient + pulsing animation + glowing rings
- **Unlocked:** Purple gradient + hover effects
- **Locked:** Gray + 🔒 + opacity 60%

**Visual Effects:**
- Floating shadow below island
- White border (8px)
- XP badge floating at bottom (+50 XP)
- Type badge at top (اختبار, تمرين, تحدي)
- Stars badge at top-right (⭐⭐⭐)
- Curved SVG paths connecting islands
- Background: floating colored blurs

**Animations:**
- Current lesson: bounce + pulse + glow
- Hover: scale(1.25) + rotate(12deg)
- Islands: fade-in one by one on load

**Example Lessons Data:**
```dart
[
  {id: 1, title: "أساسيات التاريخ", type: "lesson", completed: true, stars: 3, xp: 50, position: "right"},
  {id: 2, title: "اختبار الوحدة 1", type: "quiz", completed: true, stars: 3, xp: 30, position: "center"},
  {id: 3, title: "الحضارات القديمة", type: "lesson", completed: true, stars: 2, xp: 50, position: "left"},
  {id: 4, title: "مراجعة", type: "practice", completed: false, current: true, xp: 25, position: "right"},
  {id: 5, title: "العصور الوسطى", type: "lesson", locked: true, xp: 75, position: "center"},
  {id: 6, title: "تحدي خاص", type: "boss", locked: true, xp: 100, position: "center"},
  // ... more lessons
]
```

---

### **3. PROFILE SCREEN**

**Layout:**
```
┌─────────────────────────────────────┐
│  ← رجوع                      ☀️/🌙 │
├─────────────────────────────────────┤
│           👨‍🎓                      │  Avatar
│      خباش أحمد                      │  (ring)
│  متعلم نشيط منذ 45 يوم              │
├─────────────────────────────────────┤
│  إحصائياتك                          │
│  إجمالي النقاط .......... 555 XP   │
│  السلسلة الحالية .......... 3 🔥   │
│  الدروس المكتملة ........... 45     │
│  النجوم المحصلة ......... 128 ⭐   │
├─────────────────────────────────────┤
│  الإنجازات                          │
│  ┌──────┐ ┌──────┐ ┌──────┐        │
│  │ 🏆  │ │ 🔥  │ │ ⭐  │        │
│  │مبتدئ│ │متحمس│ │متميز│        │  Achievements
│  └──────┘ └──────┘ └──────┘        │  Grid (2x2)
│  (unlocked) (unlocked) (locked)     │
└─────────────────────────────────────┘
```

**Achievements:**
```dart
[
  {id: 1, title: "مبتدئ", desc: "أكمل أول درس", icon: "🏆", unlocked: true},
  {id: 2, title: "متحمس", desc: "سلسلة 3 أيام", icon: "🔥", unlocked: true},
  {id: 3, title: "متميز", desc: "احصل على 5 نجوم", icon: "⭐", unlocked: false},
  {id: 4, title: "عالم", desc: "أكمل 10 دروس", icon: "🎓", unlocked: false},
]
```

---

### **4. QUIZ SCREEN (Future)**

**Components:**
- Question text (centered)
- 4 answer buttons (A, B, C, D)
- Progress bar at top
- Timer (optional)
- Skip button
- Submit button
- Results feedback (correct/incorrect)

---

### **5. BOTTOM NAVIGATION BAR**

**5 Tabs:**
```dart
[
  {icon: BookOpen, label: "", screen: HomeScreen, active: true},
  {icon: Trophy, label: "", screen: LeaderboardScreen},
  {icon: Lightbulb, label: "", screen: TipsScreen},
  {icon: Flag, label: "", screen: ChallengesScreen},
  {icon: User, label: "", screen: ProfileScreen},
]
```

**Active State:**
- Highlighted icon with background circle
- Blue color
- Shadow effect
- Scale animation

---

## **🔧 FUNCTIONALITY REQUIREMENTS**

### **State Management (Provider):**

**1. ThemeProvider:**
```dart
- isDarkMode: bool
- toggleTheme()
- savePreference()
- loadPreference()
```

**2. UserProvider:**
```dart
- userName: String
- totalXP: int
- streak: int
- completedLessons: int
- totalStars: int
- achievements: List<Achievement>
- updateXP()
- incrementStreak()
- unlockAchievement()
```

**3. ProgressProvider:**
```dart
- subjects: List<Subject>
- getSubjectById()
- updateProgress()
- getLessons(subjectId)
- markLessonComplete()
- saveProgress()
- loadProgress()
```

---

### **Local Storage (SharedPreferences):**

**Keys:**
```dart
- 'theme_mode' → bool (dark/light)
- 'user_name' → String
- 'total_xp' → int
- 'streak' → int
- 'completed_lessons' → List<int>
- 'progress_data' → JSON
- 'achievements' → List<int>
- 'last_login' → DateTime
```

---

### **Navigation:**
```dart
Bottom Nav → Switch between 5 main screens
Subject Card tap → Navigate to LessonsScreen with subject data
Lesson Island tap → Navigate to QuizScreen (if unlocked)
Back button → Pop to previous screen
```

---

## **🎯 USER INTERACTIONS**

### **Home Screen:**
1. Toggle dark/light mode → Save preference
2. Tap subject card → Navigate to lessons
3. View stats → Display user progress
4. Bottom nav → Switch screens

### **Lessons Screen:**
1. Tap unlocked lesson → Start quiz/lesson
2. Tap locked lesson → Show "Complete previous lessons" message
3. Tap current lesson → Pulsing animation + navigate
4. Scroll → View all lessons in path
5. Back button → Return to home

### **Profile Screen:**
1. View stats → Read-only display
2. View achievements → Show locked/unlocked
3. Tap achievement → Show details popup

---

## **🎨 ANIMATIONS**

```dart
1. Screen transitions → Fade + Slide
2. Subject cards → Scale on hover (1.05)
3. Lesson islands → Scale(1.25) + Rotate(12deg) on hover
4. Current lesson → Bounce + Pulse + Glow rings
5. Progress bars → Animated fill (duration: 1s)
6. Stats numbers → Count-up animation on load
7. Bottom nav → Scale active icon
8. Achievement unlock → Pop + Confetti effect
9. Island appearance → Fade-in + slide-up sequentially
10. XP gain → Flying number animation
```

---

## **📐 RESPONSIVE DESIGN**

```dart
// Breakpoints
Mobile: < 600px
Tablet: 600-1024px
Desktop: > 1024px

// Grid Columns
Mobile: 1 column (subjects)
Tablet: 2 columns
Desktop: 3-4 columns

// Font Sizes
Mobile: base
Tablet: 1.1x base
Desktop: 1.2x base

// Island Sizes
Mobile: 112px (28 * 4)
Tablet: 144px (36 * 4)
Desktop: 160px (40 * 4)
Boss: 1.25x regular size
```

---

## **🔊 AUDIO (Optional)**

```dart
Sounds:
- tap.mp3 → Button/card tap
- success.mp3 → Lesson complete
- achievement.mp3 → Achievement unlock
- fail.mp3 → Wrong answer
- streak.mp3 → Daily streak

Implementation:
- Use audioplayers package
- Preload sounds
- Play on events
- Mute option in settings
```

---

## **✅ MVP CHECKLIST**

**Phase 1: Foundation (Week 1)**
- [ ] Project setup with all dependencies
- [ ] Folder structure created
- [ ] Theme system (dark/light)
- [ ] Bottom navigation
- [ ] Basic home screen layout

**Phase 2: Core Screens (Week 1-2)**
- [ ] Home screen complete with 8 subjects
- [ ] Stats cards working
- [ ] Lessons screen with Duolingo islands
- [ ] Profile screen with achievements
- [ ] Navigation between screens

**Phase 3: Interactivity (Week 2)**
- [ ] Subject progress tracking
- [ ] Lesson state management (locked/unlocked/completed)
- [ ] XP system working
- [ ] Streak counter
- [ ] Local storage saving/loading

**Phase 4: Polish (Week 2-3)**
- [ ] All animations implemented
- [ ] Curved paths between islands
- [ ] Sound effects (optional)
- [ ] Achievement system
- [ ] Responsive design for all devices

**Phase 5: Content (Week 3)**
- [ ] Add real lesson content
- [ ] Quiz system
- [ ] Questions database
- [ ] Results screen
- [ ] Progress persistence

---

## **🎯 SAMPLE DATA**

### **User:**
```dart
User(
  name: "خباش أحمد",
  totalXP: 555,
  streak: 3,
  completedLessons: 45,
  totalStars: 128,
  achievements: [1, 2], // IDs of unlocked achievements
  joinDate: DateTime(2025, 1, 1),
)
```

### **Subjects (from earlier):**
Already provided above (8 subjects)

### **Lessons (example for تاريخ):**
Already provided above (10 lessons)

---

## **🚀 COMMANDS FOR CLAUDE CODE**

**Initial Setup:**
```bash
cd learning_app
claude-code

"Based on the complete plan I provided, build the Flutter app:

1. First, update pubspec.yaml with all dependencies
2. Create the complete folder structure
3. Implement app_colors.dart and app_theme.dart
4. Create all model classes (Subject, Lesson, User, Achievement)
5. Build the providers (ThemeProvider, UserProvider, ProgressProvider)
6. Implement StorageService with SharedPreferences
7. Build HomeScreen with 8 subject cards and stats
8. Build LessonsScreen with Duolingo-style floating islands
9. Build ProfileScreen with achievements
10. Implement bottom navigation
11. Add all animations and interactions

Use the exact data, colors, and specifications from the plan.
RTL support for Arabic.
Material Design 3.
Start with step 1."
```

---

## **📝 IMPORTANT NOTES**

1. **RTL Support:** Use `Directionality(textDirection: TextDirection.rtl)` for Arabic
2. **Cairo Font:** Google Fonts for Arabic readability
3. **Null Safety:** All code must be null-safe
4. **Performance:** Optimize list rendering with `ListView.builder`
5. **Assets:** Use emojis for icons (no external assets needed initially)
6. **Testing:** Test on mobile, tablet, web
7. **Git:** Commit after each major feature

---

## **🎯 SUCCESS CRITERIA**

✅ App runs on all platforms (Android, iOS, Web)  
✅ Dark/light mode works perfectly  
✅ All 8 subjects display with correct data  
✅ Duolingo-style island path renders correctly  
✅ Curved paths connect islands  
✅ Animations are smooth (60fps)  
✅ Progress persists across app restarts  
✅ RTL layout works correctly  
✅ Responsive on all screen sizes  
✅ No errors or warnings in console  

---

## **📞 IF CLAUDE CODE ASKS QUESTIONS:**

**Q: "What color for X?"**  
A: Refer to AppColors in the plan

**Q: "What size for Y?"**  
A: Refer to Design System section

**Q: "How should Z behave?"**  
A: Refer to User Interactions section

**Q: "What data structure?"**  
A: Refer to Models section

---

**THIS IS YOUR COMPLETE BLUEPRINT! 🎯**

**Give this entire plan to Claude Code and say:**

> "Build this Flutter app exactly as specified in this plan. Follow every detail. Start with pubspec.yaml and folder structure, then implement each component systematically. Ask me if anything is unclear."

**Ready to build? Copy this plan and let's go!** 🚀