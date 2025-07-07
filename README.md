# Mystic Whisper 🔮

Mystic Whisper, görüntülerinizi mystik bir perspektifle analiz eden AI destekli bir Flutter uygulamasıdır. Gemini AI kullanarak görüntülerinizdeki gizli anlamları ve sembolik öğeleri keşfedin.

## Özellikler ✨

- **Görüntü Analizi**: Gemini AI ile güçlendirilmiş mystik görüntü analizi
- **Güzel Tasarım**: Dark mode ve yıldızlı animasyonlar ile büyülü kullanıcı deneyimi
- **Yerel Depolama**: Analiz sonuçlarınız cihazınızda güvenle saklanır
- **Çoklu Platform**: iOS ve Android'de çalışır
- **Temiz Kod**: Provider pattern ile temiz state management

## Kurulum 🚀

### Gereksinimler
- Flutter SDK (3.0.0 veya üzeri)
- Dart SDK
- Android Studio / VS Code
- iOS Simulator (iOS geliştirme için)

### Adımlar

1. **Repoyu klonlayın**
   ```bash
   git clone [repository-url]
   cd mystic_whisper
   ```

2. **Dependencies'leri kurun**
   ```bash
   flutter pub get
   ```

3. **Arka plan görüntüsünü ekleyin**
   - `assets/images/` klasörüne `bg.png` dosyanızı yerleştirin
   - Bu dosya anasayfanın arka planı olarak kullanılacak

4. **Uygulamayı çalıştırın**
   ```bash
   flutter run
   ```

## API Yapılandırması 🔧

Gemini API key'i `lib/config/api_config.dart` dosyasında yapılandırılmıştır. Üretim ortamında güvenlik için environment variables kullanmanız önerilir.

## Kullanım 📱

1. **Anasayfa**: Mystik Whisper başlığı ve upload butonu
2. **Görüntü Yükleme**: "Upload Image" butonuna tıklayarak galerisinizden görüntü seçin
3. **Analiz**: AI görüntünüzü mystik bir perspektifle analiz eder
4. **Geçmiş**: "Analyze" sekmesinde tüm analiz geçmişinizi görüntüleyin

## Proje Yapısı 📁

```
lib/
├── config/
│   └── api_config.dart          # API yapılandırması
├── models/
│   └── analysis_result.dart     # Analiz sonucu modeli
├── providers/
│   └── analysis_provider.dart   # State management
├── screens/
│   ├── home_screen.dart         # Anasayfa
│   └── analysis_screen.dart     # Analiz geçmişi
├── services/
│   ├── database_service.dart    # Yerel veritabanı
│   └── gemini_service.dart      # AI servis
├── widgets/
│   ├── animated_stars.dart      # Yıldız animasyonu
│   └── upload_button.dart       # Upload butonu
└── main.dart                    # Ana uygulama
```

## Özellikler 🎯

- **Responsive Design**: Farklı ekran boyutlarına uyum
- **Dark Theme**: Mystik atmosfer için koyu tema
- **Smooth Animations**: Akıcı geçişler ve animasyonlar
- **Error Handling**: Kapsamlı hata yönetimi
- **Local Storage**: SQLite ile yerel veri saklama

## Güvenlik 🔒

- İçerik filtreleme ile uygunsuz sonuçlar engellenir
- API key güvenliği
- Kullanıcı verilerinin yerel saklanması

## Katkıda Bulunma 🤝

1. Fork yapın
2. Feature branch oluşturun (`git checkout -b feature/amazing-feature`)
3. Commit yapın (`git commit -m 'Add amazing feature'`)
4. Push yapın (`git push origin feature/amazing-feature`)
5. Pull Request açın

## Lisans 📄

Bu proje MIT lisansı altında lisanslanmıştır.

## İletişim 📧

Herhangi bir sorunuz veya öneriniz varsa lütfen iletişime geçin.

---

**Mystic Whisper** - Görüntülerinizdeki gizli anlamları keşfedin 🔮✨ 