import { useEffect, useState } from 'react';
import { useSearchParams, Link } from 'react-router-dom';
import { CheckCircle2, XCircle, Loader2, Star } from 'lucide-react';
import axios from '../api/Config';

export default function ConfirmEmailPage() {
  const [searchParams] = useSearchParams();
  const [status, setStatus] = useState('loading'); // 'loading' | 'success' | 'error'
  const [message, setMessage] = useState('');

  useEffect(() => {
    const token = searchParams.get('token');
    if (!token) {
      setStatus('error');
      setMessage('Lien de confirmation invalide ou manquant.');
      return;
    }

    axios.get(`/auth/confirm-email?token=${token}`)
      .then((res) => {
        setStatus('success');
        setMessage(res.data.message || 'Email confirmé avec succès !');
      })
      .catch((err) => {
        setStatus('error');
        setMessage(err.response?.data?.message || 'Lien invalide ou expiré.');
      });
  }, [searchParams]);

  return (
    <div className="min-h-screen bg-gray-50 flex items-center justify-center px-4">
      <div className="bg-white rounded-3xl shadow-xl max-w-md w-full p-10 text-center">
        {/* Logo */}
        <div className="flex justify-center mb-6">
          <div className="w-16 h-16 bg-red-50 rounded-2xl flex items-center justify-center">
            <Star size={32} className="text-red-600" fill="currentColor" />
          </div>
        </div>

        {status === 'loading' && (
          <>
            <Loader2 size={48} className="text-red-500 animate-spin mx-auto mb-4" />
            <h1 className="text-2xl font-bold text-gray-900 mb-2">Vérification en cours…</h1>
            <p className="text-gray-500 text-sm">Veuillez patienter.</p>
          </>
        )}

        {status === 'success' && (
          <>
            <CheckCircle2 size={56} className="text-green-500 mx-auto mb-4" />
            <h1 className="text-2xl font-bold text-gray-900 mb-2">Email confirmé !</h1>
            <p className="text-gray-600 mb-8 leading-relaxed">{message}</p>
            <Link
              to="/login"
              className="block w-full py-3 bg-red-600 text-white rounded-xl font-semibold hover:bg-red-700 transition-colors"
            >
              Se connecter
            </Link>
          </>
        )}

        {status === 'error' && (
          <>
            <XCircle size={56} className="text-red-400 mx-auto mb-4" />
            <h1 className="text-2xl font-bold text-gray-900 mb-2">Confirmation échouée</h1>
            <p className="text-gray-600 mb-8 leading-relaxed">{message}</p>
            <div className="space-y-3">
              <Link
                to="/signup"
                className="block w-full py-3 bg-red-600 text-white rounded-xl font-semibold hover:bg-red-700 transition-colors"
              >
                Créer un nouveau compte
              </Link>
              <Link
                to="/"
                className="block w-full py-3 border border-gray-200 text-gray-600 rounded-xl font-semibold hover:bg-gray-50 transition-colors"
              >
                Retour à l'accueil
              </Link>
            </div>
          </>
        )}
      </div>
    </div>
  );
}
