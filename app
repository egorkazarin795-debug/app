<!DOCTYPE html>

<html lang="ru">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>MeandEmp — Императорский мессенджер</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

    body {
        font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, sans-serif;
        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        color: #2c3e50;
        overflow: hidden;
        height: 100vh;
    }

    #particleCanvas {
        position: fixed;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        z-index: 0;
        opacity: 0.3;
    }

    .app-container {
        position: relative;
        z-index: 1;
        max-width: 430px;
        height: 100vh;
        margin: 0 auto;
        background: rgba(255, 255, 255, 0.95);
        backdrop-filter: blur(20px);
        display: flex;
        flex-direction: column;
        box-shadow: 0 0 60px rgba(0, 0, 0, 0.3);
    }

    .app-header {
        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        color: white;
        padding: 1.5rem 1.5rem 1rem 1.5rem;
        border-radius: 0 0 25px 25px;
        box-shadow: 0 4px 20px rgba(102, 126, 234, 0.3);
    }

    .header-top {
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-bottom: 1rem;
    }

    .app-logo {
        display: flex;
        align-items: center;
        gap: 0.7rem;
        font-size: 1.5rem;
        font-weight: 700;
    }

    .logo-icon {
        font-size: 2rem;
        animation: pulse 2s infinite;
    }

    @keyframes pulse {
        0%, 100% { transform: scale(1); }
        50% { transform: scale(1.1); }
    }

    .year-badge {
        background: rgba(255, 255, 255, 0.2);
        padding: 0.4rem 0.8rem;
        border-radius: 12px;
        font-size: 0.9rem;
        font-weight: 600;
        backdrop-filter: blur(10px);
    }

    .search-bar {
        background: rgba(255, 255, 255, 0.2);
        border: 1px solid rgba(255, 255, 255, 0.3);
        border-radius: 15px;
        padding: 0.7rem 1rem;
        color: white;
        width: 100%;
        font-size: 0.95rem;
        outline: none;
        transition: all 0.3s ease;
    }

    .search-bar::placeholder {
        color: rgba(255, 255, 255, 0.7);
    }

    .search-bar:focus {
        background: rgba(255, 255, 255, 0.3);
        border-color: rgba(255, 255, 255, 0.5);
    }

    .nav-tabs {
        display: flex;
        overflow-x: auto;
        gap: 0.5rem;
        padding: 1rem 1rem 0 1rem;
        scrollbar-width: none;
        -ms-overflow-style: none;
    }

    .nav-tabs::-webkit-scrollbar {
        display: none;
    }

    .nav-tab {
        flex-shrink: 0;
        padding: 0.7rem 1.2rem;
        background: rgba(102, 126, 234, 0.1);
        border: none;
        border-radius: 20px;
        font-size: 0.9rem;
        font-weight: 600;
        color: #667eea;
        cursor: pointer;
        transition: all 0.3s ease;
        white-space: nowrap;
    }

    .nav-tab.active {
        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        color: white;
        box-shadow: 0 4px 15px rgba(102, 126, 234, 0.4);
    }

    .nav-tab:hover {
        transform: translateY(-2px);
    }

    .content-area {
        flex: 1;
        overflow-y: auto;
        padding: 1rem;
    }

    .content-section {
        display: none;
        animation: fadeIn 0.4s ease;
    }

    .content-section.active {
        display: block;
    }

    @keyframes fadeIn {
        from { opacity: 0; transform: translateY(20px); }
        to { opacity: 1; transform: translateY(0); }
    }

    .card {
        background: white;
        border-radius: 20px;
        padding: 1.2rem;
        margin-bottom: 1rem;
        box-shadow: 0 4px 15px rgba(0, 0, 0, 0.08);
        transition: all 0.3s ease;
        cursor: pointer;
    }

    .card:hover {
        transform: translateY(-3px);
        box-shadow: 0 8px 25px rgba(102, 126, 234, 0.2);
    }

    .card-header {
        display: flex;
        align-items: center;
        gap: 1rem;
        margin-bottom: 0.8rem;
    }

    .card-icon {
        font-size: 2.5rem;
        flex-shrink: 0;
    }

    .card-title {
        font-size: 1.1rem;
        font-weight: 700;
        color: #2c3e50;
        margin-bottom: 0.2rem;
    }

    .card-subtitle {
        font-size: 0.85rem;
        color: #7f8c8d;
    }

    .card-content {
        font-size: 0.95rem;
        line-height: 1.6;
        color: #555;
    }

    .card-tags {
        display: flex;
        gap: 0.5rem;
        margin-top: 0.8rem;
        flex-wrap: wrap;
    }

    .tag {
        background: linear-gradient(135deg, #667eea20, #764ba220);
        padding: 0.3rem 0.8rem;
        border-radius: 12px;
        font-size: 0.75rem;
        color: #667eea;
        font-weight: 600;
    }

    .tag.hot {
        background: linear-gradient(135deg, #ff6b6b, #ee5a6f);
        color: white;
    }

    .tag.new {
        background: linear-gradient(135deg, #4ecdc4, #44a08d);
        color: white;
    }

    .city-card {
        background: linear-gradient(135deg, rgba(102, 126, 234, 0.1), rgba(118, 75, 162, 0.1));
        border: 2px solid rgba(102, 126, 234, 0.2);
    }

    .city-stats {
        display: grid;
        grid-template-columns: repeat(3, 1fr);
        gap: 0.8rem;
        margin-top: 1rem;
    }

    .stat {
        text-align: center;
        padding: 0.6rem;
        background: white;
        border-radius: 12px;
    }

    .stat-value {
        font-size: 1.2rem;
        font-weight: 700;
        color: #667eea;
    }

    .stat-label {
        font-size: 0.75rem;
        color: #7f8c8d;
        margin-top: 0.2rem;
    }

    .video-card {
        position: relative;
        border-radius: 15px;
        overflow: hidden;
        margin-bottom: 1rem;
    }

    .video-thumbnail {
        width: 100%;
        height: 180px;
        background: linear-gradient(135deg, #667eea, #764ba2);
        display: flex;
        align-items: center;
        justify-content: center;
        font-size: 3rem;
        color: white;
        position: relative;
    }

    .play-button {
        position: absolute;
        width: 60px;
        height: 60px;
        background: rgba(255, 255, 255, 0.9);
        border-radius: 50%;
        display: flex;
        align-items: center;
        justify-content: center;
        font-size: 1.5rem;
        color: #667eea;
    }

    .video-info {
        padding: 0.8rem;
        background: white;
    }

    .video-title {
        font-weight: 700;
        margin-bottom: 0.3rem;
    }

    .video-meta {
        font-size: 0.8rem;
        color: #7f8c8d;
    }

    .chat-item {
        display: flex;
        align-items: center;
        gap: 1rem;
        padding: 1rem;
        background: white;
        border-radius: 15px;
        margin-bottom: 0.5rem;
        transition: all 0.3s ease;
        cursor: pointer;
    }

    .chat-item:hover {
        background: linear-gradient(135deg, rgba(102, 126, 234, 0.05), rgba(118, 75, 162, 0.05));
    }

    .chat-avatar {
        width: 50px;
        height: 50px;
        border-radius: 50%;
        background: linear-gradient(135deg, #667eea, #764ba2);
        display: flex;
        align-items: center;
        justify-content: center;
        font-size: 1.5rem;
        color: white;
        flex-shrink: 0;
    }

    .chat-info {
        flex: 1;
        min-width: 0;
    }

    .chat-name {
        font-weight: 700;
        font-size: 0.95rem;
        margin-bottom: 0.2rem;
    }

    .chat-message {
        font-size: 0.85rem;
        color: #7f8c8d;
        white-space: nowrap;
        overflow: hidden;
        text-overflow: ellipsis;
    }

    .chat-badge {
        background: #667eea;
        color: white;
        width: 24px;
        height: 24px;
        border-radius: 50%;
        display: flex;
        align-items: center;
        justify-content: center;
        font-size: 0.75rem;
        font-weight: 700;
    }

    /* Chat Room Overlay */
    .chat-room {
        position: fixed;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        background: white;
        z-index: 1000;
        display: none;
        flex-direction: column;
    }

    .chat-room.active {
        display: flex;
    }

    .chat-room-header {
        background: linear-gradient(135deg, #667eea, #764ba2);
        color: white;
        padding: 1rem 1.5rem;
        display: flex;
        align-items: center;
        gap: 1rem;
    }

    .back-btn {
        font-size: 1.5rem;
        cursor: pointer;
    }

    .chat-room-title {
        font-size: 1.2rem;
        font-weight: 700;
    }

    .chat-messages {
        flex: 1;
        overflow-y: auto;
        padding: 1rem;
        background: #f5f7fa;
    }

    .message {
        max-width: 80%;
        padding: 0.8rem 1rem;
        border-radius: 15px;
        margin-bottom: 0.8rem;
    }

    .message.received {
        background: white;
        margin-right: auto;
    }

    .message.sent {
        background: linear-gradient(135deg, #667eea, #764ba2);
        color: white;
        margin-left: auto;
    }

    .message-author {
        font-size: 0.75rem;
        font-weight: 700;
        margin-bottom: 0.3rem;
        opacity: 0.7;
    }

    .message-text {
        font-size: 0.95rem;
        line-height: 1.4;
    }

    .message-time {
        font-size: 0.7rem;
        margin-top: 0.3rem;
        opacity: 0.6;
    }

    .timeline-item {
        position: relative;
        padding-left: 2.5rem;
        padding-bottom: 1.5rem;
    }

    .timeline-item::before {
        content: '';
        position: absolute;
        left: 0.5rem;
        top: 0;
        bottom: -1.5rem;
        width: 2px;
        background: linear-gradient(180deg, #667eea, #764ba2);
    }

    .timeline-item:last-child::before {
        display: none;
    }

    .timeline-dot {
        position: absolute;
        left: 0;
        top: 0.3rem;
        width: 1.2rem;
        height: 1.2rem;
        background: linear-gradient(135deg, #667eea, #764ba2);
        border-radius: 50%;
        border: 3px solid white;
        box-shadow: 0 0 0 2px #667eea;
    }

    .timeline-year {
        font-size: 0.8rem;
        color: #667eea;
        font-weight: 700;
        margin-bottom: 0.3rem;
    }

    .timeline-title {
        font-weight: 700;
        margin-bottom: 0.3rem;
    }

    .timeline-text {
        font-size: 0.9rem;
        color: #555;
        line-height: 1.5;
    }

    .status-badge {
        display: inline-flex;
        align-items: center;
        gap: 0.4rem;
        padding: 0.4rem 0.8rem;
        border-radius: 20px;
        font-size: 0.8rem;
        font-weight: 600;
    }

    .status-badge.pending {
        background: #ffeaa7;
        color: #d63031;
    }

    .status-badge.approved {
        background: #55efc4;
        color: #00b894;
    }

    .status-badge.processing {
        background: #74b9ff;
        color: #0984e3;
    }

    .content-area::-webkit-scrollbar {
        width: 6px;
    }

    .content-area::-webkit-scrollbar-track {
        background: transparent;
    }

    .content-area::-webkit-scrollbar-thumb {
        background: linear-gradient(180deg, #667eea, #764ba2);
        border-radius: 10px;
    }

    @media (min-width: 768px) {
        .app-container {
            margin-top: 2rem;
            height: calc(100vh - 4rem);
            border-radius: 30px;
        }
    }
</style>

</head>
<body>
    <canvas id="particleCanvas"></canvas>

<div class="app-container">
    <div class="app-header">
        <div class="header-top">
            <div class="app-logo">
                <span class="logo-icon">👑</span>
                <span>MeandEmp</span>
            </div>
            <div class="year-badge">4129</div>
        </div>
        <input type="text" class="search-bar" placeholder="🔍 Поиск в империи...">
    </div>

    <div class="nav-tabs">
        <button class="nav-tab active" onclick="switchTab('cities')">🏛 Города</button>
        <button class="nav-tab" onclick="switchTab('travel')">✈️ Путешествия</button>
        <button class="nav-tab" onclick="switchTab('history')">📜 История</button>
        <button class="nav-tab" onclick="switchTab('court')">⚖️ Суд</button>
        <button class="nav-tab" onclick="switchTab('requests')">📝 Заявки</button>
        <button class="nav-tab" onclick="switchTab('news')">📰 Новости</button>
        <button class="nav-tab" onclick="switchTab('projects')">🚀 Проекты</button>
        <button class="nav-tab" onclick="switchTab('chats')">💬 Чаты</button>
        <button class="nav-tab" onclick="switchTab('emptube')">📺 EmpTube</button>
    </div>

    <div class="content-area">
        <!-- Cities Section -->
        <div id="cities" class="content-section active">
            <div class="card city-card">
                <div class="card-header">
                    <div class="card-icon">🏙️</div>
                    <div>
                        <div class="card-title">NewYorkl</div>
                        <div class="card-subtitle">Крупнейший мегаполис Империи</div>
                    </div>
                </div>
                <div class="card-content">
                    Финансовая и торговая столица. Небоскрёбы высотой до 2 км, непрерывный поток жизни 24/7. Город, который никогда не спит.
                </div>
                <div class="city-stats">
                    <div class="stat">
                        <div class="stat-value">24.8M</div>
                        <div class="stat-label">Население</div>
                    </div>
                    <div class="stat">
                        <div class="stat-value">2629</div>
                        <div class="stat-label">Лет</div>
                    </div>
                    <div class="stat">
                        <div class="stat-value">★ 9.9</div>
                        <div class="stat-label">Рейтинг</div>
                    </div>
                </div>
                <div class="card-tags">
                    <span class="tag hot">🔥 Самый большой</span>
                    <span class="tag">Бизнес</span>
                    <span class="tag">Развлечения</span>
                </div>
            </div>

            <div class="card city-card">
                <div class="card-header">
                    <div class="card-icon">👑</div>
                    <div>
                        <div class="card-title">Utopia</div>
                        <div class="card-subtitle">Столица Империи Karin</div>
                    </div>
                </div>
                <div class="card-content">
                    Сердце Империи. Город контрастов — от античных колонн до неоновых небоскрёбов. Здесь решается судьба миллионов.
                </div>
                <div class="city-stats">
                    <div class="stat">
                        <div class="stat-value">8.2M</div>
                        <div class="stat-label">Население</div>
                    </div>
                    <div class="stat">
                        <div class="stat-value">129</div>
                        <div class="stat-label">Лет</div>
                    </div>
                    <div class="stat">
                        <div class="stat-value">★ 9.8</div>
                        <div class="stat-label">Рейтинг</div>
                    </div>
                </div>
                <div class="card-tags">
                    <span class="tag hot">👑 Столица</span>
                    <span class="tag">Архитектура</span>
                    <span class="tag">Власть</span>
                </div>
            </div>

            <div class="card">
                <div class="card-header">
                    <div class="card-icon">🏰</div>
                    <div>
                        <div class="card-title">Brüghem</div>
                        <div class="card-subtitle">Первая столица Империи</div>
                    </div>
                </div>
                <div class="card-content">
                    Историческое сердце. Средневековые мостовые, готические соборы, дворцы. Здесь начиналась Империя в 0 году.
                </div>
                <div class="card-tags">
                    <span class="tag new">📜 Столица 0-3200</span>
                    <span class="tag">История</span>
                    <span class="tag">Музеи</span>
                </div>
            </div>

            <div class="card">
                <div class="card-header">
                    <div class="card-icon">🎭</div>
                    <div>
                        <div class="card-title">Karington</div>
                        <div class="card-subtitle">Прошлая столица (3200-4000)</div>
                    </div>
                </div>
                <div class="card-content">
                    Культурная столица. Театры, галереи, консерватории. Была столицей 800 лет. Сохранила имперский шарм.
                </div>
                <div class="card-tags">
                    <span class="tag">Искусство</span>
                    <span class="tag">Театры</span>
                    <span class="tag">Элегантность</span>
                </div>
            </div>

            <div class="card">
                <div class="card-header">
                    <div class="card-icon">🏨</div>
                    <div>
                        <div class="card-title">Blumberg</div>
                        <div class="card-subtitle">Город отелей и чистого воздуха</div>
                    </div>
                </div>
                <div class="card-content">
                    Высокогорный курорт. 5-звёздочные отели, альпийские луга, кристально чистый воздух. Лучшее место для отдыха.
                </div>
                <div class="card-tags">
                    <span class="tag">Курорт</span>
                    <span class="tag">Отели</span>
                    <span class="tag">Здоровье</span>
                </div>
            </div>

            <div class="card">
                <div class="card-header">
                    <div class="card-icon">🌊</div>
                    <div>
                        <div class="card-title">Nova Marina</div>
                        <div class="card-subtitle">Прибрежный мегаполис</div>
                    </div>
                </div>
                <div class="card-content">
                    Город будущего на берегу Сапфирового моря. Плавучие районы, биолюминесцентные набережные.
                </div>
                <div class="card-tags">
                    <span class="tag new">✨ Новинка 4127</span>
                    <span class="tag">Море</span>
                    <span class="tag">Tech</span>
                </div>
            </div>

            <div class="card">
                <div class="card-header">
                    <div class="card-icon">🏔️</div>
                    <div>
                        <div class="card-title">Crystallis Heights</div>
                        <div class="card-subtitle">Горный кластер</div>
                    </div>
                </div>
                <div class="card-content">
                    Город среди облаков. Кристальные шахты, горнолыжные курорты, обсерватории. Высота: 3200м.
                </div>
                <div class="card-tags">
                    <span class="tag">Горы</span>
                    <span class="tag">Наука</span>
                </div>
            </div>

            <div class="card">
                <div class="card-header">
                    <div class="card-icon">🌳</div>
                    <div>
                        <div class="card-title">Verdant Core</div>
                        <div class="card-subtitle">Экологическая столица</div>
                    </div>
                </div>
                <div class="card-content">
                    100% зелёной энергии. Вертикальные сады, биокупола. Самый чистый воздух в Империи.
                </div>
                <div class="card-tags">
                    <span class="tag">Эко</span>
                    <span class="tag">Инновации</span>
                </div>
            </div>
        </div>

        <!-- Travel Section -->
        <div id="travel" class="content-section">
            <div class="card">
                <div class="card-header">
                    <div class="card-icon">🎫</div>
                    <div>
                        <div class="card-title">Тур "Имперское наследие"</div>
                        <div class="card-subtitle">10 дней • 5 столиц</div>
                    </div>
                </div>
                <div class="card-content">
                    Brüghem → Karington → Utopia → NewYorkl → возвращение. Все столицы Империи за одно путешествие!
                </div>
                <div class="card-tags">
                    <span class="tag hot">🔥 Хит сезона</span>
                    <span class="tag">18,000₭</span>
                </div>
            </div>

            <div class="card">
                <div class="card-header">
                    <div class="card-icon">🏰</div>
                    <div>
                        <div class="card-title">Brüghem: корни Империи</div>
                        <div class="card-subtitle">3 дня • Историческая программа</div>
                    </div>
                </div>
                <div class="card-content">
                    Замки, соборы, музей основания. Пешие экскурсии по средневековым улицам. Ужин в трактире 1200 года.
                </div>
                <div class="card-tags">
                    <span class="tag">История</span>
                    <span class="tag">5,500₭</span>
                </div>
            </div>

            <div class="card">
                <div class="card-header">
                    <div class="card-icon">🎭</div>
                    <div>
                        <div class="card-title">Культурный Karington</div>
                        <div class="card-subtitle">4 дня • Искусство + театр</div>
                    </div>
                </div>
                <div class="card-content">
                    3 спектакля в Королевском театре, посещение 12 галерей, мастер-классы, встречи с артистами.
                </div>
                <div class="card-tags">
                    <span class="tag">Искусство</span>
                    <span class="tag">8,200₭</span>
                </div>
            </div>

            <div class="card">
                <div class="card-header">
                    <div class="card-icon">🏙️</div>
                    <div>
                        <div class="card-title">NewYorkl 24/7</div>
                        <div class="card-subtitle">5 дней • Городская жизнь</div>
                    </div>
                </div>
                <div class="card-content">
                    Небоскрёбы, ночные клубы, рынки, Бродвей-шоу, крыши с видом на город. Энергия мегаполиса!
                </div>
                <div class="card-tags">
                    <span class="tag hot">Популярно</span>
                    <span class="tag">9,800₭</span>
                </div>
            </div>

            <div class="card">
                <div class="card-header">
                    <div class="card-icon">🏨</div>
                    <div>
                        <div class="card-title">Relax в Blumberg</div>
                        <div class="card-subtitle">7 дней • All inclusive</div>
                    </div>
                </div>
                <div class="card-content">
                    5★ отель, SPA, массажи, йога на рассвете, горные прогулки, термальные источники. Перезагрузка!
                </div>
                <div class="card-tags">
                    <span class="tag">Здоровье</span>
                    <span class="tag">12,500₭</span>
                </div>
            </div>

            <div class="card">
                <div class="card-header">
                    <div class="card-icon">🏖️</div>
                    <div>
                        <div class="card-title">Острова Три Луны</div>
                        <div class="card-subtitle">Пляжный отдых класса люкс</div>
                    </div>
                </div>
                <div class="card-content">
                    Частные виллы на воде, дайвинг к затонувшим кораблям эпохи 2-й династии, SPA с термальными источниками.
                </div>
                <div class="card-tags">
                    <span class="tag">Релакс</span>
                    <span class="tag">22,000₭</span>
                </div>
            </div>

            <div class="card">
                <div class="card-header">
                    <div class="card-icon">🚂</div>
                    <div>
                        <div class="card-title">Экспресс "Кристальная стрела"</div>
                        <div class="card-subtitle">Utopia—Crystallis за 2.5 часа</div>
                    </div>
                </div>
                <div class="card-content">
                    Магнитная левитация 580 км/ч. Панорамные окна, VR-экскурсии, ресторан имперской кухни.
                </div>
                <div class="card-tags">
                    <span class="tag">Транспорт</span>
                    <span class="tag">850₭</span>
                </div>
            </div>

            <div class="card">
                <div class="card-header">
                    <div class="card-icon">🎒</div>
                    <div>
                        <div class="card-title">Молодёжный "Первопроходец"</div>
                        <div class="card-subtitle">14-30 лет • Скидка 40%</div>
                    </div>
                </div>
                <div class="card-content">
                    Хостелы, групповые активности, фестивали, бесплатные музеи. Исследуй свою Империю!
                </div>
                <div class="card-tags">
                    <span class="tag hot">🔥 Для молодёжи</span>
                    <span class="tag">Бюджет</span>
                </div>
            </div>
        </div>

        <!-- History Section -->
        <div id="history" class="content-section">
            <div class="timeline-item">
                <div class="timeline-dot"></div>
                <div class="timeline-year">4129 (сейчас)</div>
                <div class="timeline-title">Запуск MeandEmp</div>
                <div class="timeline-text">Первый всенародный мессенджер. Император Augof Kronos лично отправил первое сообщение всем гражданам.</div>
            </div>

            <div class="timeline-item">
                <div class="timeline-dot"></div>
                <div class="timeline-year">4127</div>
                <div class="timeline-title">Открытие Nova Marina</div>
                <div class="timeline-text">Завершено строительство плавучих кварталов. Население города достигло 2 миллионов за первый год.</div>
            </div>

            <div class="timeline-item">
                <div class="timeline-dot"></div>
                <div class="timeline-year">4100</div>
                <div class="timeline-title">Эра Технологий</div>
                <div class="timeline-text">Запущена первая квантовая сеть Империи. Начало цифровой революции.</div>
            </div>

            <div class="timeline-item">
                <div class="timeline-dot"></div>
                <div class="timeline-year">4050</div>
                <div class="timeline-title">Великое объединение</div>
                <div class="timeline-text">Последние независимые регионы вошли в состав Империи мирным путём через референдум.</div>
            </div>

            <div class="timeline-item">
                <div class="timeline-dot"></div>
                <div class="timeline-year">4000</div>
                <div class="timeline-title">Основание Utopia</div>
                <div class="timeline-text">Император Koll Lingstor заложил первый камень новой столицы. Строительство четырёх легендарных колонн стало символом новой эры.</div>
            </div>

            <div class="timeline-item">
                <div class="timeline-dot"></div>
                <div class="timeline-year">3200</div>
                <div class="timeline-title">Перенос столицы в Karington</div>
                <div class="timeline-text">Karington становится новой столицей Империи. Эпоха расцвета культуры и искусств.</div>
            </div>

            <div class="timeline-item">
                <div class="timeline-dot"></div>
                <div class="timeline-year">1500</div>
                <div class="timeline-title">Основание NewYorkl</div>
                <div class="timeline-text">Торговый город на пересечении морских путей быстро разрастается и становится крупнейшим мегаполисом.</div>
            </div>

            <div class="timeline-item">
                <div class="timeline-dot"></div>
                <div class="timeline-year">800</div>
                <div class="timeline-title">Золотой век Brüghem</div>
                <div class="timeline-text">Первая столица процветает. Построены великие соборы и дворцы, многие стоят до сих пор.</div>
            </div>

            <div class="timeline-item">
                <div class="timeline-dot"></div>
                <div class="timeline-year">0</div>
                <div class="timeline-title">Рождение Империи Karin</div>
                <div class="timeline-text">George Karin объединил разрозненные королевства и провозгласил Империю. Brüghem стал первой столицей. Начало имперского летоисчисления.</div>
            </div>

            <div class="card" style="margin-top: 2rem;">
                <div class="card-header">
                    <div class="card-icon">👑</div>
                    <div>
                        <div class="card-title">Династия Karin</div>
                        <div class="card-subtitle">4129 лет непрерывного правления</div>
                    </div>
                </div>
                <div class="card-content">
                    От George Karin I Основателя (0-58) до нынешнего Augof Kronos (4115-настоящее время). Самая длинная династия в истории человечества.
                </div>
            </div>
        </div>

        <!-- Court Section -->
        <div id="court" class="content-section">
            <div class="card">
                <div class="card-header">
                    <div class="card-icon">⚖️</div>
                    <div>
                        <div class="card-title">Подать иск онлайн</div>
                        <div class="card-subtitle">Цифровое правосудие 24/7</div>
                    </div>
                </div>
                <div class="card-content">
                    Заполните форму, приложите доказательства, отслеживайте статус. Средний срок: 14 дней.
                </div>
                <div class="card-tags">
                    <span class="tag new">Новая система</span>
                    <span class="tag">Быстро</span>
                </div>
            </div>

            <div class="card">
                <div class="card-header">
                    <div class="card-icon">📊</div>
                    <div>
                        <div class="card-title">Статистика судов 4129</div>
                        <div class="card-subtitle">Открытые данные</div>
                    </div>
                </div>
                <div class="card-content">
                    • Рассмотрено дел: 184,392<br>
                    • Удовлетворено: 76%<br>
                    • Средняя скорость: 12.3 дня<br>
                    • Апелляций: 8,241
                </div>
            </div>

            <div class="card">
                <div class="card-header">
                    <div class="card-icon">🎓</div>
                    <div>
                        <div class="card-title">Бесплатная юрконсультация</div>
                        <div class="card-subtitle">Для всех граждан</div>
                    </div>
                </div>
                <div class="card-content">
                    Чат с имперскими юристами 9:00-21:00. ИИ-помощник 24/7. Ответ за 5 минут.
                </div>
                <div class="card-tags">
                    <span class="tag hot">Популярно</span>
                </div>
            </div>

            <div class="card">
                <div class="card-header">
                    <div class="card-icon">📺</div>
                    <div>
                        <div class="card-title">Трансляции заседаний</div>
                        <div class="card-subtitle">Прозрачное правосудие</div>
                    </div>
                </div>
                <div class="card-content">
                    Смотрите открытые судебные процессы в прямом эфире. Архив всех дел с 4120 года.
                </div>
            </div>
        </div>

        <!-- Requests Section -->
        <div id="requests" class="content-section">
            <div class="card">
                <div class="card-header">
                    <div class="card-icon">📝</div>
                    <div>
                        <div class="card-title">Новая заявка</div>
                        <div class="card-subtitle">Любой вопрос к властям</div>
                    </div>
                </div>
                <div class="card-content">
                    Создайте обращение в любое ведомство. Жалоба, предложение, вопрос — всё рассматривается официально.
                </div>
                <div class="card-tags">
                    <span class="tag hot">Создать</span>
                </div>
            </div>

            <div class="card">
                <div class="card-header">
                    <div class="card-icon">🎫</div>
                    <div>
                        <div class="card-title">Заявка #4129-08821</div>
                        <div class="card-subtitle">Запрос на встречу с советом</div>
                    </div>
                </div>
                <div class="card-content">
                    Тема: Инициатива по озеленению района<br>
                    Статус: <span class="status-badge processing">⏳ На рассмотрении</span><br>
                    Ожидаемый ответ: 3 дня
                </div>
            </div>

            <div class="card">
                <div class="card-header">
                    <div class="card-icon">✅</div>
                    <div>
                        <div class="card-title">Заявка #4129-07654</div>
                        <div class="card-subtitle">Замена документов</div>
                    </div>
                </div>
                <div class="card-content">
                    Тема: Восстановление ID-карты<br>
                    Статус: <span class="status-badge approved">✓ Одобрено</span><br>
                    Готовность: До 15.02.4129
                </div>
            </div>

            <div class="card">
                <div class="card-header">
                    <div class="card-icon">📋</div>
                    <div>
                        <div class="card-title">Популярные запросы</div>
                        <div class="card-subtitle">Чаще всего спрашивают</div>
                    </div>
                </div>
                <div class="card-content">
                    • Получение гражданства<br>
                    • Разрешение на строительство<br>
                    • Налоговые вычеты<br>
                    • Социальные выплаты
                </div>
            </div>
        </div>

        <!-- News Section -->
        <div id="news" class="content-section">
            <div class="card">
                <div class="card-header">
                    <div class="card-icon">🔥</div>
                    <div>
                        <div class="card-title">Император объявил о новой реформе</div>
                        <div class="card-subtitle">2 часа назад • Политика</div>
                    </div>
                </div>
                <div class="card-content">
                    Augof Kronos представил план цифровизации всех госуслуг к концу 4130 года. "Каждый гражданин должен иметь доступ одним касанием."
                </div>
                <div class="card-tags">
                    <span class="tag hot">🔥 Главное</span>
                    <span class="tag">Реформы</span>
                </div>
            </div>

            <div class="card">
                <div class="card-header">
                    <div class="card-icon">🎉</div>
                    <div>
                        <div class="card-title">MeandEmp — 1 миллион пользователей!</div>
                        <div class="card-subtitle">5 часов назад • Технологии</div>
                    </div>
                </div>
                <div class="card-content">
                    Всего за неделю после запуска! Разработчики обещают новые фичи каждый месяц.
                </div>
                <div class="card-tags">
                    <span class="tag new">Технологии</span>
                </div>
            </div>

            <div class="card">
                <div class="card-header">
                    <div class="card-icon">🏗️</div>
                    <div>
                        <div class="card-title">В Utopia построят парк будущего</div>
                        <div class="card-subtitle">Вчера • Градостроительство</div>
                    </div>
                </div>
                <div class="card-content">
                    50-гектарный парк с искусственным озером, голографическими инсталляциями и бесплатным Wi-Fi.
                </div>
                <div class="card-tags">
                    <span class="tag">Утопия</span>
                    <span class="tag">Развитие</span>
                </div>
            </div>

            <div class="card">
                <div class="card-header">
                    <div class="card-icon">🎭</div>
                    <div>
                        <div class="card-title">Фестиваль "Три Луны" — 20 февраля</div>
                        <div class="card-subtitle">3 дня назад • Культура</div>
                    </div>
                </div>
                <div class="card-content">
                    Крупнейший музыкальный фестиваль в 8 городах. 200+ артистов, бесплатный вход до 25 лет.
                </div>
                <div class="card-tags">
                    <span class="tag hot">Событие</span>
                </div>
            </div>

            <div class="card">
                <div class="card-header">
                    <div class="card-icon">🌱</div>
                    <div>
                        <div class="card-title">Империя достигла углеродной нейтральности</div>
                        <div class="card-subtitle">Неделю назад • Экология</div>
                    </div>
                </div>
                <div class="card-content">
                    Выбросы CO₂ полностью компенсированы. Цель — отрицательный след к 4135.
                </div>
                <div class="card-tags">
                    <span class="tag">Эко</span>
                    <span class="tag">Достижение</span>
                </div>
            </div>
        </div>

        <!-- Projects Section -->
        <div id="projects" class="content-section">
            <div class="card">
                <div class="card-header">
                    <div class="card-icon">🚀</div>
                    <div>
                        <div class="card-title">Космодром "Новый горизонт"</div>
                        <div class="card-subtitle">Запуск: 4132</div>
                    </div>
                </div>
                <div class="card-content">
                    Первый гражданский космопорт. Рейсы на орбитальную станцию. Бюджет: 2.4 трлн ₭.
                </div>
                <div class="card-tags">
                    <span class="tag hot">🔥 Мега-проект</span>
                    <span class="tag">Космос</span>
                </div>
            </div>

            <div class="card">
                <div class="card-header">
                    <div class="card-icon">🌐</div>
                    <div>
                        <div class="card-title">EmpNet 2.0</div>
                        <div class="card-subtitle">В разработке</div>
                    </div>
                </div>
                <div class="card-content">
                    Квантовый интернет. Скорость ×1000. Полное покрытие к 4131 году.
                </div>
                <div class="card-tags">
                    <span class="tag new">Инфраструктура</span>
                    <span class="tag">Tech</span>
                </div>
            </div>

            <div class="card">
                <div class="card-header">
                    <div class="card-icon">🏫</div>
                    <div>
                        <div class="card-title">Университет Будущего</div>
                        <div class="card-subtitle">Открытие: осень 4129</div>
                    </div>
                </div>
                <div class="card-content">
                    50,000 студентов. AI-преподаватели, VR-лаборатории, бесплатное обучение топ-10%.
                </div>
                <div class="card-tags">
                    <span class="tag">Образование</span>
                    <span class="tag hot">Набор открыт</span>
                </div>
            </div>

            <div class="card">
                <div class="card-header">
                    <div class="card-icon">🏥</div>
                    <div>
                        <div class="card-title">Программа "Здоровье нации"</div>
                        <div class="card-subtitle">Запущена в 4129</div>
                    </div>
                </div>
                <div class="card-content">
                    Бесплатная генетическая диагностика. AI-мониторинг 24/7. Цель: 95 лет средняя продолжительность.
                </div>
                <div class="card-tags">
                    <span class="tag">Здоровье</span>
                    <span class="tag new">Новинка</span>
                </div>
            </div>

            <div class="card">
                <div class="card-header">
                    <div class="card-icon">🎨</div>
                    <div>
                        <div class="card-title">Голографический музей</div>
                        <div class="card-subtitle">Открыт в 4128</div>
                    </div>
                </div>
                <div class="card-content">
                    Первый в мире полностью голографический музей истории. Оживающие исторические сцены.
                </div>
                <div class="card-tags">
                    <span class="tag">Культура</span>
                    <span class="tag">Инновации</span>
                </div>
            </div>
        </div>

        <!-- Chats Section -->
        <div id="chats" class="content-section">
            <div class="chat-item" onclick="openChat('support')">
                <div class="chat-avatar">👨‍💼</div>
                <div class="chat-info">
                    <div class="chat-name">Имперская поддержка</div>
                    <div class="chat-message">Ваша заявка одобрена! Подробности →</div>
                </div>
                <div class="chat-badge">3</div>
            </div>

            <div class="chat-item" onclick="openChat('youth')">
                <div class="chat-avatar">👥</div>
                <div class="chat-info">
                    <div class="chat-name">Молодёжь Utopia</div>
                    <div class="chat-message">@alex: кто на фестиваль в субботу?</div>
                </div>
                <div class="chat-badge">12</div>
            </div>

            <div class="chat-item" onclick="openChat('university')">
                <div class="chat-avatar">🎓</div>
                <div class="chat-info">
                    <div class="chat-name">Университет Будущего</div>
                    <div class="chat-message">Дни открытых дверей 25-26 февраля!</div>
                </div>
                <div class="chat-badge">1</div>
            </div>

            <div class="chat-item" onclick="openChat('emperor')">
                <div class="chat-avatar">👑</div>
                <div class="chat-info">
                    <div class="chat-name">Канал Императора</div>
                    <div class="chat-message">Новый указ о налоговых льготах...</div>
                </div>
            </div>

            <div class="chat-item" onclick="openChat('travelers')">
                <div class="chat-avatar">✈️</div>
                <div class="chat-info">
                    <div class="chat-name">Путешественники Karin</div>
                    <div class="chat-message">Кто был на островах Три Луны?</div>
                </div>
                <div class="chat-badge">8</div>
            </div>

            <div class="chat-item" onclick="openChat('gamers')">
                <div class="chat-avatar">🎮</div>
                <div class="chat-info">
                    <div class="chat-name">Геймеры Империи</div>
                    <div class="chat-message">"Битва за Утопию" вышла!</div>
                </div>
                <div class="chat-badge">24</div>
            </div>

            <div class="chat-item" onclick="openChat('food')">
                <div class="chat-avatar">🍕</div>
                <div class="chat-info">
                    <div class="chat-name">Еда и рестораны</div>
                    <div class="chat-message">Лучшая пицца в Nova Marina?</div>
                </div>
                <div class="chat-badge">5</div>
            </div>

            <div class="chat-item" onclick="openChat('books')">
                <div class="chat-avatar">📚</div>
                <div class="chat-info">
                    <div class="chat-name">Книжный клуб</div>
                    <div class="chat-message">"Хроники династии" — обсуждение...</div>
                </div>
            </div>
        </div>

        <!-- EmpTube Section -->
        <div id="emptube" class="content-section">
            <div class="video-card">
                <div class="video-thumbnail">
                    🎬
                    <div class="play-button">▶</div>
                </div>
                <div class="video-info">
                    <div class="video-title">LIVE: Обращение императора к нации</div>
                    <div class="video-meta">👁 2.4M • Сейчас в эфире</div>
                </div>
            </div>

            <div class="video-card">
                <div class="video-thumbnail" style="background: linear-gradient(135deg, #ff6b6b, #ee5a6f);">
                    🎸
                    <div class="play-button">▶</div>
                </div>
                <div class="video-info">
                    <div class="video-title">Фестиваль "Три Луны" 4129 — ПОЛНЫЙ КОНЦЕРТ</div>
                    <div class="video-meta">👁 892K • 2 дня • Музыка</div>
                </div>
            </div>

            <div class="video-card">
                <div class="video-thumbnail" style="background: linear-gradient(135deg, #4ecdc4, #44a08d);">
                    🏛️
                    <div class="play-button">▶</div>
                </div>
                <div class="video-info">
                    <div class="video-title">Utopia: от колонн до небоскрёбов | Экскурсия 4K</div>
                    <div class="video-meta">👁 1.2M • 1 неделю • Путешествия</div>
                </div>
            </div>

            <div class="video-card">
                <div class="video-thumbnail" style="background: linear-gradient(135deg, #a29bfe, #6c5ce7);">
                    🚀
                    <div class="play-button">▶</div>
                </div>
                <div class="video-info">
                    <div class="video-title">Космодром "Новый горизонт" — репортаж со стройки</div>
                    <div class="video-meta">👁 645K • 3 дня • Проекты</div>
                </div>
            </div>

            <div class="video-card">
                <div class="video-thumbnail" style="background: linear-gradient(135deg, #fdcb6e, #e17055);">
                    🎓
                    <div class="play-button">▶</div>
                </div>
                <div class="video-info">
                    <div class="video-title">Как поступить в Университет Будущего? Гид 4129</div>
                    <div class="video-meta">👁 428K • 5 дней • Образование</div>
                </div>
            </div>

            <div class="video-card">
                <div class="video-thumbnail" style="background: linear-gradient(135deg, #74b9ff, #0984e3);">
                    🎮
                    <div class="play-button">▶</div>
                </div>
                <div class="video-info">
                    <div class="video-title">ПЕРВЫЙ ВЗГЛЯД: "Битва за Утопию" VR</div>
                    <div class="video-meta">👁 1.8M • 1 день • Игры</div>
                </div>
            </div>

            <div class="video-card">
                <div class="video-thumbnail" style="background: linear-gradient(135deg, #fd79a8, #e84393);">
                    🏰
                    <div class="play-button">▶</div>
                </div>
                <div class="video-info">
                    <div class="video-title">Brüghem: первая столица | 4129 лет истории</div>
                    <div class="video-meta">👁 524K • 4 дня • История</div>
                </div>
            </div>

            <div class="video-card">
                <div class="video-thumbnail" style="background: linear-gradient(135deg, #55efc4, #00b894);">
                    🎭
                    <div class="play-button">▶</div>
                </div>
                <div class="video-info">
                    <div class="video-title">Королевский театр Karington — премьера</div>
                    <div class="video-meta">👁 312K • 6 дней • Культура</div>
                </div>
            </div>

            <div class="video-card">
                <div class="video-thumbnail" style="background: linear-gradient(135deg, #ffeaa7, #fdcb6e);">
                    🏙️
                    <div class="play-button">▶</div>
                </div>
                <div class="video-info">
                    <div class="video-title">NewYorkl за 24 часа | Что успеть в мегаполисе</div>
                    <div class="video-meta">👁 978K • 3 дня • Путешествия</div>
                </div>
            </div>

            <div class="video-card">
                <div class="video-thumbnail" style="background: linear-gradient(135deg, #81ecec, #00cec9);">
                    🏨
                    <div class="play-button">▶</div>
                </div>
                <div class="video-info">
                    <div class="video-title">Blumberg: 7 лучших отелей для отдыха</div>
                    <div class="video-meta">👁 445K • 1 неделю • Путешествия</div>
                </div>
            </div>

            <div class="video-card">
                <div class="video-thumbnail" style="background: linear-gradient(135deg, #fab1a0, #e17055);">
                    🍕
                    <div class="play-button">▶</div>
                </div>
                <div class="video-info">
                    <div class="video-title">Уличная еда в 8 городах Империи</div>
                    <div class="video-meta">👁 1.1M • 2 дня • Еда</div>
                </div>
            </div>

            <div class="video-card">
                <div class="video-thumbnail" style="background: linear-gradient(135deg, #dfe6e9, #b2bec3);">
                    🏔️
                    <div class="play-button">▶</div>
                </div>
                <div class="video-info">
                    <div class="video-title">Crystallis Heights: жизнь в облаках</div>
                    <div class="video-meta">👁 687K • 5 дней • Документ</div>
                </div>
            </div>

            <div class="video-card">
                <div class="video-thumbnail" style="background: linear-gradient(135deg, #a29bfe, #6c5ce7);">
                    🌊
                    <div class="play-button">▶</div>
                </div>
                <div class="video-info">
                    <div class="video-title">Nova Marina: плавучий город будущего</div>
                    <div class="video-meta">👁 1.5M • 1 неделю • Tech</div>
                </div>
            </div>

            <div class="video-card">
                <div class="video-thumbnail" style="background: linear-gradient(135deg, #00b894, #00cec9);">
                    🌳
                    <div class="play-button">▶</div>
                </div>
                <div class="video-info">
                    <div class="video-title">Verdant Core: как город стал углеродно-нейтральным</div>
                    <div class="video-meta">👁 823K • 4 дня • Экология</div>
                </div>
            </div>

            <div class="video-card">
                <div class="video-thumbnail" style="background: linear-gradient(135deg, #ff7675, #d63031);">
                    🎉
                    <div class="play-button">▶</div>
                </div>
                <div class="video-info">
                    <div class="video-title">День Империи 4129 — полный парад в Utopia</div>
                    <div class="video-meta">👁 3.2M • 2 недели • События</div>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Chat Rooms Overlays -->
<div id="chat-youth" class="chat-room">
    <div class="chat-room-header">
        <span class="back-btn" onclick="closeChat()">←</span>
        <span class="chat-room-title">Молодёжь Utopia</span>
    </div>
    <div class="chat-messages">
        <div class="message received">
            <div class="message-author">@alex</div>
            <div class="message-text">йоу, кто на фестиваль в субботу? говорят будет огонь 🔥</div>
            <div class="message-time">14:23</div>
        </div>
        <div class="message received">
            <div class="message-author">@marina_k</div>
            <div class="message-text">я иду 100%! взяла билеты ещё месяц назад</div>
            <div class="message-time">14:25</div>
        </div>
        <div class="message received">
            <div class="message-author">@viktor_88</div>
            <div class="message-text">кто-нибудь был на прошлогоднем? как там вообще?</div>
            <div class="message-time">14:27</div>
        </div>
        <div class="message received">
            <div class="message-author">@luna_star</div>
            <div class="message-text">прошлый год был эпичный! 3 дня, 8 сцен, куча артистов. в этом году обещают ещё круче</div>
            <div class="message-time">14:30</div>
        </div>
        <div class="message received">
            <div class="message-author">@denis_ch</div>
            <div class="message-text">а до 25 лет вход бесплатный? или это фейк?</div>
            <div class="message-time">14:32</div>
        </div>
        <div class="message received">
            <div class="message-author">@alex</div>
            <div class="message-text">не фейк, проверено! показываешь ID и заходишь</div>
            <div class="message-time">14:33</div>
        </div>
        <div class="message sent">
            <div class="message-text">супер! значит встречаемся там ✨</div>
            <div class="message-time">14:35</div>
        </div>
        <div class="message received">
            <div class="message-author">@marina_k</div>
            <div class="message-text">давайте созвонимся в пятницу и договоримся где встретимся</div>
            <div class="message-time">14:36</div>
        </div>
    </div>
</div>

<div id="chat-gamers" class="chat-room">
    <div class="chat-room-header">
        <span class="back-btn" onclick="closeChat()">←</span>
        <span class="chat-room-title">Геймеры Империи</span>
    </div>
    <div class="chat-messages">
        <div class="message received">
            <div class="message-author">@pro_gamer_2k</div>
            <div class="message-text">БРАТЬЯ! "Битва за Утопию" вышла наконец!! 🎮</div>
            <div class="message-time">12:04</div>
        </div>
        <div class="message received">
            <div class="message-author">@xX_destroyer_Xx</div>
            <div class="message-text">уже качаю! 120 гигов, но оно того стоит</div>
            <div class="message-time">12:06</div>
        </div>
        <div class="message received">
            <div class="message-author">@cyber_ninja</div>
            <div class="message-text">графика просто космос, видел стримы</div>
            <div class="message-time">12:09</div>
        </div>
        <div class="message received">
            <div class="message-author">@luna_plays</div>
            <div class="message-text">кто-нибудь уже пробовал VR-режим?</div>
            <div class="message-time">12:12</div>
        </div>
        <div class="message received">
            <div class="message-author">@vr_master</div>
            <div class="message-text">я уже 2 часа в VR, это нереально! ощущение что реально в Утопии ходишь</div>
            <div class="message-time">12:15</div>
        </div>
        <div class="message sent">
            <div class="message-text">кто хочет в кооп? собираю команду на вечер</div>
            <div class="message-time">12:18</div>
        </div>
        <div class="message received">
            <div class="message-author">@team_player</div>
            <div class="message-text">я в деле! какой уровень?</div>
            <div class="message-time">12:19</div>
        </div>
        <div class="message received">
            <div class="message-author">@sniper_elite</div>
            <div class="message-text">и я! нужен хороший снайпер? 😎</div>
            <div class="message-time">12:21</div>
        </div>
    </div>
</div>

<div id="chat-travelers" class="chat-room">
    <div class="chat-room-header">
        <span class="back-btn" onclick="closeChat()">←</span>
        <span class="chat-room-title">Путешественники Karin</span>
    </div>
    <div class="chat-messages">
        <div class="message received">
            <div class="message-author">@world_explorer</div>
            <div class="message-text">кто был на островах Три Луны? стоит ехать?</div>
            <div class="message-time">09:15</div>
        </div>
        <div class="message received">
            <div class="message-author">@beach_lover</div>
            <div class="message-text">был в прошлом месяце! рай на земле, советую 100%</div>
            <div class="message-time">09:18</div>
        </div>
        <div class="message received">
            <div class="message-author">@travel_addict</div>
            <div class="message-text">только дорого. но если есть бюджет — не пожалеешь</div>
            <div class="message-time">09:22</div>
        </div>
        <div class="message received">
            <div class="message-author">@world_explorer</div>
            <div class="message-text">а что насчёт Blumberg? думаю между ним и островами</div>
            <div class="message-time">09:25</div>
        </div>
        <div class="message received">
            <div class="message-author">@mountain_girl</div>
            <div class="message-text">Blumberg — другая история. если хочешь релакс и горы — туда. если пляж — острова</div>
            <div class="message-time">09:28</div>
        </div>
        <div class="message sent">
            <div class="message-text">а кто-нибудь ездил в NewYorkl недавно?</div>
            <div class="message-time">09:30</div>
        </div>
        <div class="message received">
            <div class="message-author">@city_boy</div>
            <div class="message-text">был на прошлой неделе! город не спит реально 24/7, энергия зашкаливает</div>
            <div class="message-time">09:32</div>
        </div>
    </div>
</div>

<script>
    // Particle Animation
    const canvas = document.getElementById('particleCanvas');
    const ctx = canvas.getContext('2d');
    canvas.width = window.innerWidth;
    canvas.height = window.innerHeight;

    window.addEventListener('resize', () => {
        canvas.width = window.innerWidth;
        canvas.height = window.innerHeight;
    });

    class Particle {
        constructor() {
            this.x = Math.random() * canvas.width;
            this.y = Math.random() * canvas.height;
            this.size = Math.random() * 2 + 1;
            this.speedX = Math.random() * 0.5 - 0.25;
            this.speedY = Math.random() * 0.5 - 0.25;
            this.color = Math.random() > 0.5 ? 'rgba(102, 126, 234, 0.4)' : 'rgba(118, 75, 162, 0.4)';
        }

        update() {
            this.x += this.speedX;
            this.y += this.speedY;
            if (this.x > canvas.width) this.x = 0;
            if (this.x < 0) this.x = canvas.width;
            if (this.y > canvas.height) this.y = 0;
            if (this.y < 0) this.y = canvas.height;
        }

        draw() {
            ctx.fillStyle = this.color;
            ctx.beginPath();
            ctx.arc(this.x, this.y, this.size, 0, Math.PI * 2);
            ctx.fill();
        }
    }

    const particlesArray = [];
    for (let i = 0; i < 50; i++) {
        particlesArray.push(new Particle());
    }

    function animate() {
        ctx.clearRect(0, 0, canvas.width, canvas.height);
        for (let particle of particlesArray) {
            particle.update();
            particle.draw();
        }
        requestAnimationFrame(animate);
    }
    animate();

    // Tab Switching
    function switchTab(tabName) {
        const tabs = document.querySelectorAll('.nav-tab');
        tabs.forEach(tab => tab.classList.remove('active'));
        event.target.classList.add('active');

        const sections = document.querySelectorAll('.content-section');
        sections.forEach(section => section.classList.remove('active'));
        document.getElementById(tabName).classList.add('active');

        document.querySelector('.content-area').scrollTop = 0;
    }

    // Chat Room Functions
    function openChat(chatId) {
        const chatRoom = document.getElementById(`chat-${chatId}`);
        if (chatRoom) {
            chatRoom.classList.add('active');
        }
    }

    function closeChat() {
        const chatRooms = document.querySelectorAll('.chat-room');
        chatRooms.forEach(room => room.classList.remove('active'));
    }
</script>

</body>
</html>
