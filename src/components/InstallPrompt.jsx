import { useState, useEffect } from 'react';
import { Download, X, Smartphone, Share } from 'lucide-react';

function isIOS() {
  return /iPad|iPhone|iPod/.test(navigator.userAgent) && !window.MSStream;
}

function isInStandaloneMode() {
  return window.matchMedia('(display-mode: standalone)').matches || window.navigator.standalone;
}

function wasDismissedRecently() {
  const dismissed = localStorage.getItem('pwa-prompt-dismissed');
  return dismissed && Date.now() - parseInt(dismissed) < 7 * 24 * 60 * 60 * 1000;
}

export default function InstallPrompt() {
  const [deferredPrompt, setDeferredPrompt] = useState(null);
  const [showAndroid, setShowAndroid] = useState(false);
  const [showIOS, setShowIOS] = useState(false);

  useEffect(() => {
    // Ne rien afficher si déjà installé ou rejeté récemment
    if (isInStandaloneMode() || wasDismissedRecently()) return;

    // iOS : pas d'événement beforeinstallprompt, on détecte directement
    if (isIOS()) {
      setShowIOS(true);
      return;
    }

    // Android / Chrome : écouter l'événement natif
    const handler = (e) => {
      e.preventDefault();
      setDeferredPrompt(e);
      setShowAndroid(true);
    };
    window.addEventListener('beforeinstallprompt', handler);
    return () => window.removeEventListener('beforeinstallprompt', handler);
  }, []);

  const handleInstallAndroid = async () => {
    if (!deferredPrompt) return;
    deferredPrompt.prompt();
    const { outcome } = await deferredPrompt.userChoice;
    if (outcome === 'accepted') setShowAndroid(false);
    setDeferredPrompt(null);
  };

  const handleDismiss = () => {
    setShowAndroid(false);
    setShowIOS(false);
    localStorage.setItem('pwa-prompt-dismissed', Date.now().toString());
  };

  // Bannière Android
  if (showAndroid) {
    return (
      <div className="fixed bottom-4 left-4 right-4 z-50 md:left-auto md:right-4 md:w-96">
        <div className="bg-white rounded-2xl shadow-2xl border border-gray-100 p-4 flex items-start gap-3">
          <div className="w-12 h-12 rounded-xl bg-red-600 flex items-center justify-center flex-shrink-0">
            <Smartphone size={22} className="text-white" />
          </div>
          <div className="flex-1 min-w-0">
            <p className="font-semibold text-gray-900 text-sm">Installer EchoWork</p>
            <p className="text-xs text-gray-500 mt-0.5">
              Accédez rapidement à l'app depuis votre écran d'accueil
            </p>
            <button
              onClick={handleInstallAndroid}
              className="mt-2 flex items-center gap-1.5 bg-red-600 hover:bg-red-700 text-white text-xs font-medium px-3 py-1.5 rounded-full transition-colors"
            >
              <Download size={13} />
              Installer
            </button>
          </div>
          <button onClick={handleDismiss} className="text-gray-400 hover:text-gray-600 flex-shrink-0">
            <X size={18} />
          </button>
        </div>
      </div>
    );
  }

  // Guide iOS (Safari ne supporte pas beforeinstallprompt)
  if (showIOS) {
    return (
      <div className="fixed bottom-4 left-4 right-4 z-50">
        <div className="bg-white rounded-2xl shadow-2xl border border-gray-100 p-4">
          <div className="flex items-start gap-3">
            <div className="w-12 h-12 rounded-xl bg-red-600 flex items-center justify-center flex-shrink-0">
              <Smartphone size={22} className="text-white" />
            </div>
            <div className="flex-1">
              <p className="font-semibold text-gray-900 text-sm">Installer EchoWork</p>
              <p className="text-xs text-gray-500 mt-0.5 mb-3">
                Ajoutez l'app à votre écran d'accueil en 2 étapes :
              </p>
              <div className="space-y-2">
                <div className="flex items-center gap-2 text-xs text-gray-700">
                  <span className="w-5 h-5 rounded-full bg-red-100 text-red-600 flex items-center justify-center font-bold text-xs flex-shrink-0">1</span>
                  <span>Appuyez sur <Share size={12} className="inline mb-0.5" /> <strong>Partager</strong> en bas de Safari</span>
                </div>
                <div className="flex items-center gap-2 text-xs text-gray-700">
                  <span className="w-5 h-5 rounded-full bg-red-100 text-red-600 flex items-center justify-center font-bold text-xs flex-shrink-0">2</span>
                  <span>Sélectionnez <strong>"Sur l'écran d'accueil"</strong></span>
                </div>
              </div>
            </div>
            <button onClick={handleDismiss} className="text-gray-400 hover:text-gray-600 flex-shrink-0">
              <X size={18} />
            </button>
          </div>
          {/* Flèche pointant vers le bas (bouton Share de Safari) */}
          <div className="absolute -bottom-2 left-1/2 -translate-x-1/2 w-4 h-4 bg-white border-r border-b border-gray-100 rotate-45" />
        </div>
      </div>
    );
  }

  return null;
}
