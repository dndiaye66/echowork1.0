import { useState } from 'react';
import { useNavigate, useLocation, Link } from 'react-router-dom';
import { useAuth } from '../contexts/AuthContext';
import axios from '../api/Config';
import { Eye, EyeOff, User, Lock, ArrowRight, Star, Shield } from 'lucide-react';

function LoginPage() {
  const [username, setUsername] = useState('');
  const [password, setPassword] = useState('');
  const [showPassword, setShowPassword] = useState(false);
  const [error, setError] = useState('');
  const [loading, setLoading] = useState(false);
  const navigate = useNavigate();
  const location = useLocation();
  const { login } = useAuth();

  const handleSubmit = async (e) => {
    e.preventDefault();
    setError('');
    setLoading(true);

    try {
      const response = await axios.post('/auth/login', { username, password });
      login(response.data.user, response.data.accessToken);
      navigate(location.state?.from || '/', { replace: true });
    } catch (err) {
      setError(err.response?.data?.message || 'Connexion échouée. Vérifiez vos identifiants.');
    } finally {
      setLoading(false);
    }
  };

  return (
    <div className="min-h-screen flex">
      {/* Left panel — branding */}
      <div className="hidden lg:flex lg:w-1/2 relative overflow-hidden bg-gradient-to-br from-secondary via-secondary/90 to-primary flex-col items-center justify-center p-12 text-secondary-content">
        <div className="absolute inset-0 opacity-10">
          <div className="absolute top-10 right-10 w-64 h-64 rounded-full bg-white blur-3xl" />
          <div className="absolute bottom-20 left-10 w-80 h-80 rounded-full bg-white blur-3xl" />
        </div>

        <div className="relative z-10 max-w-md text-center">
          <div className="mb-8 flex justify-center">
            <div className="w-20 h-20 bg-white/20 backdrop-blur-sm rounded-2xl flex items-center justify-center border border-white/30 shadow-xl">
              <Star size={40} className="text-white" fill="currentColor" />
            </div>
          </div>

          <h1 className="text-4xl font-extrabold mb-4 tracking-tight">EchoWork</h1>
          <p className="text-xl font-light mb-8 text-white/80">
            Bon retour ! Accédez à votre espace et gérez vos évaluations.
          </p>

          <div className="bg-white/10 backdrop-blur-sm rounded-2xl p-6 border border-white/20">
            <Shield size={32} className="text-white/80 mx-auto mb-3" />
            <p className="text-white/80 text-sm font-medium">Connexion sécurisée</p>
            <p className="text-white/50 text-xs mt-1">Vos données sont protégées avec JWT et chiffrement bcrypt.</p>
          </div>

          <div className="mt-12 pt-8 border-t border-white/20">
            <p className="text-white/60 text-sm">Pas encore de compte ?</p>
            <Link
              to="/signup"
              className="mt-2 inline-flex items-center gap-2 text-white font-semibold hover:underline underline-offset-4"
            >
              S'inscrire gratuitement <ArrowRight size={16} />
            </Link>
          </div>
        </div>
      </div>

      {/* Right panel — form */}
      <div className="flex-1 flex items-center justify-center px-6 py-12 bg-base-100">
        <div className="w-full max-w-md">
          {/* Mobile logo */}
          <div className="lg:hidden flex justify-center mb-8">
            <div className="w-14 h-14 bg-secondary/10 rounded-xl flex items-center justify-center">
              <Star size={28} className="text-secondary" fill="currentColor" />
            </div>
          </div>

          <div className="mb-8">
            <h2 className="text-3xl font-bold text-base-content">Connexion</h2>
            <p className="text-base-content/50 mt-1 text-sm">
              Entrez vos identifiants pour accéder à votre compte.
            </p>
          </div>

          {error && (
            <div className="alert alert-error mb-5 py-3">
              <svg className="shrink-0 w-5 h-5" viewBox="0 0 20 20" fill="currentColor">
                <path fillRule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zM8.28 7.22a.75.75 0 00-1.06 1.06L8.94 10l-1.72 1.72a.75.75 0 101.06 1.06L10 11.06l1.72 1.72a.75.75 0 101.06-1.06L11.06 10l1.72-1.72a.75.75 0 00-1.06-1.06L10 8.94 8.28 7.22z" clipRule="evenodd" />
              </svg>
              <span className="text-sm">{error}</span>
            </div>
          )}

          <form onSubmit={handleSubmit} className="space-y-5">
            {/* Username */}
            <div>
              <label className="block text-sm font-medium text-base-content mb-1.5">
                Pseudo
              </label>
              <div className="relative">
                <User size={16} className="absolute left-3 top-1/2 -translate-y-1/2 text-base-content/40" />
                <input
                  type="text"
                  placeholder="Votre pseudo"
                  className="input input-bordered w-full pl-9 focus:input-secondary transition-all"
                  value={username}
                  onChange={(e) => setUsername(e.target.value)}
                  required
                />
              </div>
            </div>

            {/* Password */}
            <div>
              <div className="flex items-center justify-between mb-1.5">
                <label className="block text-sm font-medium text-base-content">
                  Mot de passe
                </label>
              </div>
              <div className="relative">
                <Lock size={16} className="absolute left-3 top-1/2 -translate-y-1/2 text-base-content/40" />
                <input
                  type={showPassword ? 'text' : 'password'}
                  placeholder="Votre mot de passe"
                  className="input input-bordered w-full pl-9 pr-10 focus:input-secondary transition-all"
                  value={password}
                  onChange={(e) => setPassword(e.target.value)}
                  required
                />
                <button
                  type="button"
                  className="absolute right-3 top-1/2 -translate-y-1/2 text-base-content/40 hover:text-base-content transition-colors"
                  onClick={() => setShowPassword(!showPassword)}
                >
                  {showPassword ? <EyeOff size={16} /> : <Eye size={16} />}
                </button>
              </div>
            </div>

            {/* Submit */}
            <button
              type="submit"
              className="btn btn-secondary w-full mt-2 gap-2"
              disabled={loading}
            >
              {loading ? (
                <span className="loading loading-spinner loading-sm" />
              ) : (
                <>
                  Se connecter <ArrowRight size={16} />
                </>
              )}
            </button>
          </form>

          {/* Séparateur */}
          <div className="flex items-center gap-3 my-5">
            <div className="flex-1 h-px bg-base-300" />
            <span className="text-xs text-base-content/40 font-medium">OU</span>
            <div className="flex-1 h-px bg-base-300" />
          </div>

          {/* Bouton Google */}
          <a
            href={`${import.meta.env.VITE_API_URL}/auth/google`}
            className="btn btn-outline w-full gap-3 border-gray-200 hover:border-gray-300 hover:bg-gray-50 text-gray-700 font-medium"
          >
            <svg viewBox="0 0 24 24" width="18" height="18">
              <path fill="#4285F4" d="M22.56 12.25c0-.78-.07-1.53-.2-2.25H12v4.26h5.92c-.26 1.37-1.04 2.53-2.21 3.31v2.77h3.57c2.08-1.92 3.28-4.74 3.28-8.09z" />
              <path fill="#34A853" d="M12 23c2.97 0 5.46-.98 7.28-2.66l-3.57-2.77c-.98.66-2.23 1.06-3.71 1.06-2.86 0-5.29-1.93-6.16-4.53H2.18v2.84C3.99 20.53 7.7 23 12 23z" />
              <path fill="#FBBC05" d="M5.84 14.09c-.22-.66-.35-1.36-.35-2.09s.13-1.43.35-2.09V7.07H2.18C1.43 8.55 1 10.22 1 12s.43 3.45 1.18 4.93l3.66-2.84z" />
              <path fill="#EA4335" d="M12 5.38c1.62 0 3.06.56 4.21 1.64l3.15-3.15C17.45 2.09 14.97 1 12 1 7.7 1 3.99 3.47 2.18 7.07l3.66 2.84c.87-2.6 3.3-4.53 6.16-4.53z" />
            </svg>
            Continuer avec Google
          </a>

          <p className="text-center text-sm text-base-content/50 mt-6">
            Pas encore de compte ?{' '}
            <Link to="/signup" className="text-secondary font-semibold hover:underline underline-offset-2">
              S'inscrire
            </Link>
          </p>
        </div>
      </div>
    </div>
  );
}

export default LoginPage;
