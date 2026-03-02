import { useState } from 'react';
import { useNavigate, Link } from 'react-router-dom';
import { useAuth } from '../contexts/AuthContext';
import axios from '../api/Config';
import {
  Eye, EyeOff, User, Mail, Lock, CheckCircle2, ArrowRight,
  Star, Building2, UserCircle2, Phone,
} from 'lucide-react';

function PasswordStrength({ password }) {
  const checks = [
    { label: '6 caractères minimum', ok: password.length >= 6 },
    { label: 'Une majuscule', ok: /[A-Z]/.test(password) },
    { label: 'Un chiffre', ok: /[0-9]/.test(password) },
  ];
  const score = checks.filter((c) => c.ok).length;
  const colors = ['bg-error', 'bg-warning', 'bg-warning', 'bg-success'];
  const labels = ['', 'Faible', 'Moyen', 'Fort'];

  if (!password) return null;

  return (
    <div className="mt-2 space-y-1">
      <div className="flex gap-1">
        {[0, 1, 2].map((i) => (
          <div
            key={i}
            className={`h-1 flex-1 rounded-full transition-all duration-300 ${
              i < score ? colors[score] : 'bg-base-300'
            }`}
          />
        ))}
      </div>
      <p className={`text-xs font-medium ${score === 3 ? 'text-success' : score >= 2 ? 'text-warning' : 'text-error'}`}>
        {labels[score]}
      </p>
      <ul className="space-y-0.5">
        {checks.map((c) => (
          <li key={c.label} className={`text-xs flex items-center gap-1 ${c.ok ? 'text-success' : 'text-base-content/40'}`}>
            <CheckCircle2 size={11} />
            {c.label}
          </li>
        ))}
      </ul>
    </div>
  );
}

function SignupPage() {
  const [accountType, setAccountType] = useState('personal'); // 'personal' | 'company'
  const [username, setUsername] = useState('');
  const [email, setEmail] = useState('');
  const [password, setPassword] = useState('');
  const [companyName, setCompanyName] = useState('');
  const [firstName, setFirstName] = useState('');
  const [lastName, setLastName] = useState('');
  const [phone, setPhone] = useState('');
  const [showPassword, setShowPassword] = useState(false);
  const [error, setError] = useState('');
  const [loading, setLoading] = useState(false);
  const navigate = useNavigate();
  const { login } = useAuth();

  const isCompany = accountType === 'company';

  const handleSubmit = async (e) => {
    e.preventDefault();
    setError('');
    setLoading(true);

    if (!email || !/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email)) {
      setError('Adresse email invalide.');
      setLoading(false);
      return;
    }
    if (password.length < 6) {
      setError('Le mot de passe doit contenir au moins 6 caractères.');
      setLoading(false);
      return;
    }

    if (isCompany) {
      if (!companyName.trim()) { setError("Le nom de l'entreprise est requis."); setLoading(false); return; }
      if (!firstName.trim()) { setError('Le prénom du responsable est requis.'); setLoading(false); return; }
      if (!lastName.trim()) { setError('Le nom du responsable est requis.'); setLoading(false); return; }
      if (!phone.trim()) { setError('Le numéro de téléphone est requis.'); setLoading(false); return; }
    } else {
      if (!username || username.length < 3) {
        setError('Le pseudo doit contenir au moins 3 caractères.');
        setLoading(false);
        return;
      }
    }

    try {
      const payload = isCompany
        ? { email, password, firstName, lastName, phone, companyName: companyName.trim(), accountType: 'company' }
        : { username, email, password };

      const response = await axios.post('/auth/signup', payload);
      login(response.data.user, response.data.accessToken);
      navigate('/');
    } catch (err) {
      setError(err.response?.data?.message || 'Inscription échouée. Veuillez réessayer.');
    } finally {
      setLoading(false);
    }
  };

  /* ── Left-panel content per account type ── */
  const leftContent = isCompany
    ? {
        title: 'Votre vitrine digitale',
        subtitle: 'Inscrivez votre entreprise sur EchoWork et renforcez votre réputation auprès de milliers de Sénégalais.',
        features: [
          'Tableau de bord dédié à votre entreprise',
          'Répondez aux avis de vos clients',
          'Boostez votre visibilité avec des publications',
        ],
      }
    : {
        title: 'Rejoignez la communauté',
        subtitle: 'La plateforme de référence pour noter et évaluer les entreprises au Sénégal.',
        features: [
          'Notez les entreprises en toute transparence',
          'Consultez des milliers d\'avis vérifiés',
          'Trouvez les meilleures entreprises par secteur',
        ],
      };

  return (
    <div className="min-h-screen flex">

      {/* ── Left panel (branding) ── */}
      <div className="hidden lg:flex lg:w-1/2 relative overflow-hidden bg-gradient-to-br from-primary via-primary/90 to-secondary flex-col items-center justify-center p-12 text-primary-content">
        <div className="absolute inset-0 opacity-10">
          <div className="absolute top-10 left-10 w-64 h-64 rounded-full bg-white blur-3xl" />
          <div className="absolute bottom-20 right-10 w-80 h-80 rounded-full bg-white blur-3xl" />
        </div>

        <div className="relative z-10 max-w-md text-center">
          <div className="mb-8 flex justify-center">
            <div className="w-20 h-20 bg-white/20 backdrop-blur-sm rounded-2xl flex items-center justify-center border border-white/30 shadow-xl">
              {isCompany
                ? <Building2 size={40} className="text-white" />
                : <Star size={40} className="text-white" fill="currentColor" />
              }
            </div>
          </div>

          <h1 className="text-4xl font-extrabold mb-4 tracking-tight">EchoWork</h1>
          <p className="text-xl font-light mb-8 text-white/80">{leftContent.subtitle}</p>

          <ul className="space-y-4 text-left">
            {leftContent.features.map((feat) => (
              <li key={feat} className="flex items-start gap-3">
                <CheckCircle2 size={20} className="mt-0.5 shrink-0 text-white/90" />
                <span className="text-white/85 text-sm">{feat}</span>
              </li>
            ))}
          </ul>

          <div className="mt-12 pt-8 border-t border-white/20">
            <p className="text-white/60 text-sm">Déjà inscrit ?</p>
            <Link
              to="/login"
              className="mt-2 inline-flex items-center gap-2 text-white font-semibold hover:underline underline-offset-4"
            >
              Se connecter <ArrowRight size={16} />
            </Link>
          </div>
        </div>
      </div>

      {/* ── Right panel (form) ── */}
      <div className="flex-1 flex items-center justify-center px-6 py-12 bg-base-100">
        <div className="w-full max-w-md">

          {/* Mobile logo */}
          <div className="lg:hidden flex justify-center mb-8">
            <div className="w-14 h-14 bg-primary/10 rounded-xl flex items-center justify-center">
              <Star size={28} className="text-primary" fill="currentColor" />
            </div>
          </div>

          <div className="mb-6">
            <h2 className="text-3xl font-bold text-base-content">Créer un compte</h2>
            <p className="text-base-content/50 mt-1 text-sm">Rejoignez EchoWork gratuitement.</p>
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

            {/* Company name — only for company accounts */}
            {isCompany && (
              <div>
                <label className="block text-sm font-medium text-base-content mb-1.5">
                  Nom de l'entreprise <span className="text-error">*</span>
                </label>
                <div className="relative">
                  <Building2 size={16} className="absolute left-3 top-1/2 -translate-y-1/2 text-base-content/40" />
                  <input
                    type="text"
                    placeholder="Ex: Société Sénégalaise XYZ"
                    className="input input-bordered w-full pl-9 focus:input-primary transition-all"
                    value={companyName}
                    onChange={(e) => setCompanyName(e.target.value)}
                    required={isCompany}
                  />
                </div>
              </div>
            )}

            {/* Company: Prénom + Nom côte à côte */}
            {isCompany ? (
              <div className="grid grid-cols-2 gap-3">
                <div>
                  <label className="block text-sm font-medium text-base-content mb-1.5">
                    Prénom <span className="text-error">*</span>
                  </label>
                  <div className="relative">
                    <User size={16} className="absolute left-3 top-1/2 -translate-y-1/2 text-base-content/40" />
                    <input
                      type="text"
                      placeholder="Prénom"
                      className="input input-bordered w-full pl-9 focus:input-primary transition-all"
                      value={firstName}
                      onChange={(e) => setFirstName(e.target.value)}
                      required
                    />
                  </div>
                </div>
                <div>
                  <label className="block text-sm font-medium text-base-content mb-1.5">
                    Nom <span className="text-error">*</span>
                  </label>
                  <input
                    type="text"
                    placeholder="Nom de famille"
                    className="input input-bordered w-full focus:input-primary transition-all"
                    value={lastName}
                    onChange={(e) => setLastName(e.target.value)}
                    required
                  />
                </div>
              </div>
            ) : (
              /* Personal: Pseudo */
              <div>
                <label className="block text-sm font-medium text-base-content mb-1.5">
                  Pseudo <span className="text-error">*</span>
                </label>
                <div className="relative">
                  <User size={16} className="absolute left-3 top-1/2 -translate-y-1/2 text-base-content/40" />
                  <input
                    type="text"
                    placeholder="Votre pseudo"
                    className="input input-bordered w-full pl-9 focus:input-primary transition-all"
                    value={username}
                    onChange={(e) => setUsername(e.target.value)}
                    required={!isCompany}
                    minLength={3}
                  />
                </div>
              </div>
            )}

            {/* Email */}
            <div>
              <label className="block text-sm font-medium text-base-content mb-1.5">
                {isCompany ? 'Email professionnel' : 'Adresse email'} <span className="text-error">*</span>
              </label>
              <div className="relative">
                <Mail size={16} className="absolute left-3 top-1/2 -translate-y-1/2 text-base-content/40" />
                <input
                  type="email"
                  placeholder={isCompany ? 'contact@monentreprise.sn' : 'vous@exemple.com'}
                  className="input input-bordered w-full pl-9 focus:input-primary transition-all"
                  value={email}
                  onChange={(e) => setEmail(e.target.value)}
                  required
                />
              </div>
            </div>

            {/* Phone — company only */}
            {isCompany && (
              <div>
                <label className="block text-sm font-medium text-base-content mb-1.5">
                  Numéro de téléphone <span className="text-error">*</span>
                </label>
                <div className="relative">
                  <Phone size={16} className="absolute left-3 top-1/2 -translate-y-1/2 text-base-content/40" />
                  <input
                    type="tel"
                    placeholder="Ex: 77 123 45 67"
                    className="input input-bordered w-full pl-9 focus:input-primary transition-all"
                    value={phone}
                    onChange={(e) => setPhone(e.target.value)}
                    required
                  />
                </div>
              </div>
            )}

            {/* Password */}
            <div>
              <label className="block text-sm font-medium text-base-content mb-1.5">
                Mot de passe <span className="text-error">*</span>
              </label>
              <div className="relative">
                <Lock size={16} className="absolute left-3 top-1/2 -translate-y-1/2 text-base-content/40" />
                <input
                  type={showPassword ? 'text' : 'password'}
                  placeholder="Au moins 6 caractères"
                  className="input input-bordered w-full pl-9 pr-10 focus:input-primary transition-all"
                  value={password}
                  onChange={(e) => setPassword(e.target.value)}
                  required
                  minLength={6}
                />
                <button
                  type="button"
                  className="absolute right-3 top-1/2 -translate-y-1/2 text-base-content/40 hover:text-base-content transition-colors"
                  onClick={() => setShowPassword(!showPassword)}
                >
                  {showPassword ? <EyeOff size={16} /> : <Eye size={16} />}
                </button>
              </div>
              <PasswordStrength password={password} />
            </div>

            {/* Submit */}
            <button
              type="submit"
              className="btn btn-primary w-full mt-2 gap-2"
              disabled={loading}
            >
              {loading ? (
                <span className="loading loading-spinner loading-sm" />
              ) : (
                <>
                  {isCompany ? 'Inscrire mon entreprise' : 'Créer mon compte'}
                  <ArrowRight size={16} />
                </>
              )}
            </button>
          </form>

          <p className="text-center text-sm text-base-content/50 mt-6">
            Déjà un compte ?{' '}
            <Link to="/login" className="text-primary font-semibold hover:underline underline-offset-2">
              Se connecter
            </Link>
          </p>
        </div>
      </div>
    </div>
  );
}

export default SignupPage;
