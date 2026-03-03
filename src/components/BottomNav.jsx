import { Link, useLocation } from 'react-router-dom';
import { useState } from 'react';
import { Home, Search, Grid2x2, User, X, LogOut, LayoutDashboard } from 'lucide-react';
import { useAuth } from '../contexts/AuthContext';
import { useCategories } from '../hooks/useCategory';
import {
  Wheat, Utensils, Truck, ShoppingCart, Building2,
  Factory, Hospital, Briefcase, Phone, Zap, Landmark,
  GraduationCap, Home as HomeIcon, UtensilsCrossed, Monitor,
} from 'lucide-react';

const catIconMap = {
  'agriculture': Wheat,
  'agriculture-et-alimentation': Wheat,
  'alimentation-et-boissons': Utensils,
  'automobile': Truck,
  'commerce-et-distribution': ShoppingCart,
  'construction-et-btp': Building2,
  'industrie': Factory,
  'sante-et-pharmacie': Hospital,
  'services': Briefcase,
  'telecommunications': Phone,
  'energie-et-petrole': Zap,
  'banques-et-institutions-financieres': Landmark,
  'etablissements-d-enseignement-superieur': GraduationCap,
  'ecole-et-enseignement-superieure': GraduationCap,
  'transport-et-logistique': Truck,
  'immobilier': HomeIcon,
  'restauration-et-hotellerie': UtensilsCrossed,
  'informatique-et-numerique': Monitor,
};

export default function BottomNav() {
  const location = useLocation();
  const { isAuthenticated, user, logout } = useAuth();
  const { categories } = useCategories();
  const [showCatSheet, setShowCatSheet] = useState(false);
  const [showAccountSheet, setShowAccountSheet] = useState(false);

  // Masquer sur les pages admin
  if (location.pathname.startsWith('/admin')) return null;

  const isHome = location.pathname === '/';
  const isCat = location.pathname.startsWith('/categories');
  const isAuth = location.pathname === '/login' || location.pathname === '/signup';

  return (
    <>
      {/* Barre de navigation fixe en bas */}
      <nav className="md:hidden fixed bottom-0 left-0 right-0 z-40 bg-white border-t border-gray-100 safe-area-inset-bottom"
           style={{ boxShadow: '0 -2px 12px rgba(0,0,0,0.08)' }}>
        <div className="flex items-center h-16">

          {/* Accueil */}
          <Link to="/" className={`flex-1 flex flex-col items-center gap-1 py-2 transition-colors ${isHome ? 'text-red-600' : 'text-gray-400'}`}>
            <Home size={22} strokeWidth={isHome ? 2.5 : 1.8} />
            <span className="text-[10px] font-semibold">Accueil</span>
          </Link>

          {/* Catégories */}
          <button
            onClick={() => { setShowCatSheet(true); setShowAccountSheet(false); }}
            className={`flex-1 flex flex-col items-center gap-1 py-2 transition-colors ${isCat || showCatSheet ? 'text-red-600' : 'text-gray-400'}`}
          >
            <Grid2x2 size={22} strokeWidth={isCat || showCatSheet ? 2.5 : 1.8} />
            <span className="text-[10px] font-semibold">Catégories</span>
          </button>

          {/* Bouton central Donner un avis */}
          <div className="flex-1 flex justify-center">
            <Link
              to="/login"
              className="w-12 h-12 rounded-full bg-red-600 flex items-center justify-center shadow-lg shadow-red-200 -mt-4"
            >
              <Search size={20} className="text-white" strokeWidth={2} />
            </Link>
          </div>

          {/* Mon Compte */}
          <button
            onClick={() => {
              if (!isAuthenticated) return;
              setShowAccountSheet(true);
              setShowCatSheet(false);
            }}
            className={`flex-1 flex flex-col items-center gap-1 py-2 transition-colors ${isAuth || showAccountSheet ? 'text-red-600' : 'text-gray-400'}`}
          >
            {isAuthenticated ? (
              <div className={`w-6 h-6 rounded-full bg-red-600 text-white flex items-center justify-center text-xs font-bold uppercase ${showAccountSheet ? 'ring-2 ring-red-300' : ''}`}>
                {user?.username?.[0]}
              </div>
            ) : (
              <Link to="/login" className="flex flex-col items-center gap-1">
                <User size={22} strokeWidth={1.8} />
                <span className="text-[10px] font-semibold text-gray-400">Connexion</span>
              </Link>
            )}
            {isAuthenticated && <span className="text-[10px] font-semibold">{user?.username?.slice(0, 8)}</span>}
          </button>

          {/* Inscription */}
          {!isAuthenticated && (
            <Link to="/signup" className={`flex-1 flex flex-col items-center gap-1 py-2 transition-colors ${location.pathname === '/signup' ? 'text-red-600' : 'text-gray-400'}`}>
              <User size={22} strokeWidth={location.pathname === '/signup' ? 2.5 : 1.8} />
              <span className="text-[10px] font-semibold">Inscription</span>
            </Link>
          )}
        </div>
      </nav>

      {/* Sheet Catégories */}
      {showCatSheet && (
        <>
          <div className="md:hidden fixed inset-0 bg-black/40 z-50" onClick={() => setShowCatSheet(false)} />
          <div className="md:hidden fixed bottom-0 left-0 right-0 z-50 bg-white rounded-t-3xl shadow-2xl max-h-[75vh] flex flex-col">
            <div className="flex items-center justify-between px-5 py-4 border-b border-gray-100">
              <h3 className="font-bold text-gray-900 text-base">Catégories</h3>
              <button onClick={() => setShowCatSheet(false)} className="p-1.5 rounded-full hover:bg-gray-100">
                <X size={18} />
              </button>
            </div>
            <div className="overflow-y-auto p-4 grid grid-cols-2 gap-2 pb-6">
              {categories?.map((cat) => {
                const Icon = catIconMap[cat.slug] || Briefcase;
                return (
                  <Link
                    key={cat.slug}
                    to={`/categories/${cat.slug}`}
                    onClick={() => setShowCatSheet(false)}
                    className="flex items-center gap-3 p-3 rounded-xl bg-gray-50 hover:bg-red-50 transition-colors"
                  >
                    <div className="w-8 h-8 rounded-lg bg-red-100 flex items-center justify-center flex-shrink-0">
                      <Icon size={15} className="text-red-600" />
                    </div>
                    <span className="text-xs font-medium text-gray-700 leading-tight">{cat.name}</span>
                  </Link>
                );
              })}
            </div>
          </div>
        </>
      )}

      {/* Sheet Compte */}
      {showAccountSheet && isAuthenticated && (
        <>
          <div className="md:hidden fixed inset-0 bg-black/40 z-50" onClick={() => setShowAccountSheet(false)} />
          <div className="md:hidden fixed bottom-0 left-0 right-0 z-50 bg-white rounded-t-3xl shadow-2xl">
            <div className="p-5">
              <div className="flex items-center gap-3 mb-5">
                <div className="w-12 h-12 rounded-full bg-red-600 text-white flex items-center justify-center text-lg font-bold uppercase">
                  {user?.username?.[0]}
                </div>
                <div>
                  <p className="font-bold text-gray-900">{user?.username}</p>
                  <p className="text-sm text-gray-500">{user?.email}</p>
                </div>
              </div>
              {user?.role === 'ADMIN' && (
                <Link
                  to="/admin"
                  onClick={() => setShowAccountSheet(false)}
                  className="flex items-center gap-3 w-full p-3 rounded-xl hover:bg-gray-50 transition-colors mb-1"
                >
                  <LayoutDashboard size={18} className="text-gray-600" />
                  <span className="font-medium text-gray-700">Administration</span>
                </Link>
              )}
              <button
                onClick={() => { logout(); setShowAccountSheet(false); }}
                className="flex items-center gap-3 w-full p-3 rounded-xl hover:bg-red-50 transition-colors text-red-600"
              >
                <LogOut size={18} />
                <span className="font-medium">Déconnexion</span>
              </button>
              <div className="h-6" />
            </div>
          </div>
        </>
      )}
    </>
  );
}
