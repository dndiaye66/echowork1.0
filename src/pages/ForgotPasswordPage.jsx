import { useState } from 'react';
import { Link } from 'react-router-dom';
import { Mail, ArrowRight, CheckCircle2, Star } from 'lucide-react';
import axios from '../api/Config';

export default function ForgotPasswordPage() {
  const [email, setEmail] = useState('');
  const [loading, setLoading] = useState(false);
  const [sent, setSent] = useState(false);
  const [error, setError] = useState('');

  const handleSubmit = async (e) => {
    e.preventDefault();
    setError('');
    if (!email || !/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email)) {
      setError('Adresse email invalide.');
      return;
    }
    setLoading(true);
    try {
      await axios.post('/auth/forgot-password', { email });
      setSent(true);
    } catch {
      setError('Une erreur est survenue. Veuillez réessayer.');
    } finally {
      setLoading(false);
    }
  };

  return (
    <div className="min-h-screen bg-gray-50 flex items-center justify-center px-4">
      <div className="bg-white rounded-3xl shadow-xl max-w-md w-full p-10">
        {/* Logo */}
        <div className="flex justify-center mb-6">
          <div className="w-14 h-14 bg-red-50 rounded-xl flex items-center justify-center">
            <Star size={28} className="text-red-600" fill="currentColor" />
          </div>
        </div>

        {sent ? (
          <div className="text-center">
            <CheckCircle2 size={52} className="text-green-500 mx-auto mb-4" />
            <h1 className="text-2xl font-bold text-gray-900 mb-3">Email envoyé !</h1>
            <p className="text-gray-600 text-sm leading-relaxed mb-8">
              Si un compte est associé à <strong>{email}</strong>, vous recevrez un lien
              de réinitialisation dans quelques minutes. Vérifiez aussi vos spams.
            </p>
            <Link
              to="/login"
              className="block w-full py-3 bg-red-600 text-white rounded-xl font-semibold hover:bg-red-700 transition-colors text-center"
            >
              Retour à la connexion
            </Link>
          </div>
        ) : (
          <>
            <h1 className="text-2xl font-bold text-gray-900 mb-1">Mot de passe oublié ?</h1>
            <p className="text-gray-500 text-sm mb-8">
              Entrez votre email et nous vous enverrons un lien pour réinitialiser votre mot de passe.
            </p>

            {error && (
              <div className="alert alert-error mb-5 py-3 text-sm">
                <span>{error}</span>
              </div>
            )}

            <form onSubmit={handleSubmit} className="space-y-5">
              <div>
                <label className="block text-sm font-medium text-gray-700 mb-1.5">
                  Adresse email
                </label>
                <div className="relative">
                  <Mail size={16} className="absolute left-3 top-1/2 -translate-y-1/2 text-gray-400" />
                  <input
                    type="email"
                    placeholder="vous@exemple.com"
                    className="input input-bordered w-full pl-9"
                    value={email}
                    onChange={(e) => setEmail(e.target.value)}
                    required
                    autoFocus
                  />
                </div>
              </div>

              <button
                type="submit"
                className="btn btn-primary w-full gap-2"
                disabled={loading}
              >
                {loading ? (
                  <span className="loading loading-spinner loading-sm" />
                ) : (
                  <>Envoyer le lien <ArrowRight size={16} /></>
                )}
              </button>
            </form>

            <p className="text-center text-sm text-gray-500 mt-6">
              <Link to="/login" className="text-red-600 font-semibold hover:underline underline-offset-2">
                ← Retour à la connexion
              </Link>
            </p>
          </>
        )}
      </div>
    </div>
  );
}
