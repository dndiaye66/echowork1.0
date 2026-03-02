import { useEffect, useState } from 'react';
import { useNavigate, Link, Outlet, useLocation } from 'react-router-dom';
import { useAuth } from '../../contexts/AuthContext';
import axios from '../../api/Config';
import {
  Users, Building2, MessageSquare, Briefcase, TrendingUp,
  CheckCircle, Clock, Star, FolderTree, BarChart3, LayoutDashboard,
  LogOut, ChevronRight, Bell, Menu, X
} from 'lucide-react';

const NAV_ITEMS = [
  { label: 'Tableau de bord', icon: LayoutDashboard, path: '/admin' },
  { label: 'Entreprises', icon: Building2, path: '/admin/companies' },
  { label: 'Catégories', icon: FolderTree, path: '/admin/categories' },
  { label: 'Utilisateurs', icon: Users, path: '/admin/users' },
  { label: 'Modération', icon: MessageSquare, path: '/admin/reviews', badge: 'pending' },
  { label: 'Offres d\'emploi', icon: Briefcase, path: '/admin/job-offers' },
  { label: 'Publicités', icon: TrendingUp, path: '/admin/advertisements' },
  { label: 'Analytiques', icon: BarChart3, path: '/admin/analytics' },
];

function StatCard({ icon: Icon, label, value, desc, color }) {
  const colorMap = {
    primary: 'bg-primary/10 text-primary',
    secondary: 'bg-secondary/10 text-secondary',
    accent: 'bg-accent/10 text-accent',
    warning: 'bg-warning/10 text-warning',
    info: 'bg-info/10 text-info',
    success: 'bg-success/10 text-success',
    error: 'bg-error/10 text-error',
  };
  return (
    <div className="bg-base-100 rounded-2xl p-5 shadow-sm border border-base-200 flex items-start gap-4">
      <div className={`w-12 h-12 rounded-xl flex items-center justify-center shrink-0 ${colorMap[color]}`}>
        <Icon size={22} />
      </div>
      <div className="min-w-0">
        <p className="text-xs text-base-content/50 font-medium uppercase tracking-wide truncate">{label}</p>
        <p className="text-2xl font-bold text-base-content mt-0.5">{value ?? '—'}</p>
        {desc && <p className="text-xs text-base-content/40 mt-0.5">{desc}</p>}
      </div>
    </div>
  );
}

function AdminDashboard() {
  const { user, isAuthenticated, logout } = useAuth();
  const navigate = useNavigate();
  const location = useLocation();
  const [stats, setStats] = useState(null);
  const [loading, setLoading] = useState(true);
  const [sidebarOpen, setSidebarOpen] = useState(false);

  useEffect(() => {
    if (!isAuthenticated || user?.role !== 'ADMIN') {
      navigate('/');
      return;
    }
    fetchDashboardStats();
  }, [isAuthenticated, user, navigate]);

  const fetchDashboardStats = async () => {
    try {
      const response = await axios.get('/admin/dashboard/stats');
      setStats(response.data);
    } catch (error) {
      console.error('Failed to fetch dashboard stats:', error);
    } finally {
      setLoading(false);
    }
  };

  const isActive = (path) =>
    path === '/admin' ? location.pathname === '/admin' : location.pathname.startsWith(path);

  const pendingCount = stats?.stats?.pendingReviews ?? 0;

  const Sidebar = () => (
    <aside className="flex flex-col h-full bg-base-100 border-r border-base-200 w-64">
      {/* Logo */}
      <div className="flex items-center gap-3 px-5 py-5 border-b border-base-200">
        <div className="w-9 h-9 rounded-xl bg-primary flex items-center justify-center">
          <Star size={18} className="text-primary-content" fill="currentColor" />
        </div>
        <div>
          <p className="font-bold text-base-content text-sm">EchoWork</p>
          <p className="text-xs text-base-content/40">Administration</p>
        </div>
      </div>

      {/* Nav */}
      <nav className="flex-1 overflow-y-auto py-4 px-3 space-y-0.5">
        {NAV_ITEMS.map(({ label, icon: Icon, path, badge }) => {
          const active = isActive(path);
          return (
            <Link
              key={path}
              to={path}
              onClick={() => setSidebarOpen(false)}
              className={`flex items-center gap-3 px-3 py-2.5 rounded-xl text-sm font-medium transition-all group ${
                active
                  ? 'bg-primary text-primary-content shadow-sm'
                  : 'text-base-content/60 hover:bg-base-200 hover:text-base-content'
              }`}
            >
              <Icon size={17} />
              <span className="flex-1">{label}</span>
              {badge === 'pending' && pendingCount > 0 && (
                <span className={`text-xs px-1.5 py-0.5 rounded-full font-bold ${active ? 'bg-primary-content/20 text-primary-content' : 'bg-warning text-warning-content'}`}>
                  {pendingCount}
                </span>
              )}
            </Link>
          );
        })}
      </nav>

      {/* User */}
      <div className="px-4 py-4 border-t border-base-200">
        <div className="flex items-center gap-3 px-3 py-2 rounded-xl bg-base-200/50">
          <div className="w-8 h-8 rounded-full bg-primary/20 flex items-center justify-center text-primary font-bold text-sm uppercase">
            {user?.username?.[0] ?? 'A'}
          </div>
          <div className="flex-1 min-w-0">
            <p className="text-sm font-semibold text-base-content truncate">{user?.username}</p>
            <p className="text-xs text-base-content/40 truncate">{user?.email}</p>
          </div>
          <button
            onClick={() => { logout?.(); navigate('/'); }}
            className="text-base-content/30 hover:text-error transition-colors"
            title="Déconnexion"
          >
            <LogOut size={15} />
          </button>
        </div>
      </div>
    </aside>
  );

  if (loading) {
    return (
      <div className="min-h-screen flex items-center justify-center bg-base-200">
        <div className="flex flex-col items-center gap-3">
          <span className="loading loading-spinner loading-lg text-primary" />
          <p className="text-sm text-base-content/50">Chargement du tableau de bord...</p>
        </div>
      </div>
    );
  }

  return (
    <div className="flex h-screen bg-base-200 overflow-hidden">
      {/* Desktop sidebar */}
      <div className="hidden lg:flex shrink-0">
        <Sidebar />
      </div>

      {/* Mobile sidebar overlay */}
      {sidebarOpen && (
        <div className="lg:hidden fixed inset-0 z-50 flex">
          <div className="fixed inset-0 bg-black/50" onClick={() => setSidebarOpen(false)} />
          <div className="relative z-10 flex w-64">
            <Sidebar />
          </div>
        </div>
      )}

      {/* Main content */}
      <div className="flex-1 flex flex-col overflow-hidden">
        {/* Top bar */}
        <header className="bg-base-100 border-b border-base-200 px-6 py-3 flex items-center justify-between shrink-0">
          <div className="flex items-center gap-3">
            <button
              className="lg:hidden btn btn-ghost btn-sm btn-square"
              onClick={() => setSidebarOpen(true)}
            >
              <Menu size={18} />
            </button>
            <div>
              <h1 className="text-lg font-bold text-base-content leading-none">Tableau de bord</h1>
              <p className="text-xs text-base-content/40 mt-0.5">Bienvenue, {user?.username}</p>
            </div>
          </div>
          <div className="flex items-center gap-2">
            {pendingCount > 0 && (
              <Link to="/admin/reviews" className="btn btn-warning btn-sm gap-1.5">
                <Bell size={14} />
                <span className="hidden sm:inline">{pendingCount} avis en attente</span>
                <span className="sm:hidden">{pendingCount}</span>
              </Link>
            )}
          </div>
        </header>

        {/* Scrollable body */}
        <main className="flex-1 overflow-y-auto p-6">
          {/* Stats grid */}
          {stats && (
            <div className="grid grid-cols-1 sm:grid-cols-2 xl:grid-cols-4 gap-4 mb-8">
              <StatCard icon={Users} label="Utilisateurs" value={stats.stats.totalUsers} desc="Comptes inscrits" color="primary" />
              <StatCard icon={Building2} label="Entreprises" value={stats.stats.totalCompanies} desc="Référencées" color="secondary" />
              <StatCard icon={MessageSquare} label="Avis" value={stats.stats.totalReviews} desc={`${stats.stats.approvedReviews} approuvés`} color="accent" />
              <StatCard icon={Star} label="Note moyenne" value={stats.stats.averageRating} desc="Sur 5.0" color="warning" />
              <StatCard icon={Clock} label="En attente" value={stats.stats.pendingReviews} desc="Modération requise" color="info" />
              <StatCard icon={CheckCircle} label="Approuvés" value={stats.stats.approvedReviews} desc="Publiés" color="success" />
              <StatCard icon={Briefcase} label="Offres d'emploi" value={stats.stats.totalJobOffers} desc="Publiées" color="primary" />
              <StatCard icon={TrendingUp} label="Publicités" value={stats.stats.activeAdvertisements} desc={`sur ${stats.stats.totalAdvertisements} total`} color="secondary" />
            </div>
          )}

          {/* Quick actions */}
          <div className="mb-8">
            <h2 className="text-base font-semibold text-base-content/70 mb-3 uppercase tracking-wide text-xs">Actions rapides</h2>
            <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4 gap-3">
              {NAV_ITEMS.slice(1).map(({ label, icon: Icon, path }) => (
                <Link
                  key={path}
                  to={path}
                  className="flex items-center gap-3 bg-base-100 rounded-xl px-4 py-3 border border-base-200 hover:border-primary hover:shadow-sm transition-all group"
                >
                  <div className="w-8 h-8 rounded-lg bg-base-200 group-hover:bg-primary/10 flex items-center justify-center transition-colors">
                    <Icon size={15} className="text-base-content/50 group-hover:text-primary transition-colors" />
                  </div>
                  <span className="text-sm font-medium text-base-content/70 group-hover:text-base-content flex-1 transition-colors">{label}</span>
                  <ChevronRight size={14} className="text-base-content/20 group-hover:text-primary transition-colors" />
                </Link>
              ))}
            </div>
          </div>

          {/* Recent data */}
          {stats && (
            <div className="grid grid-cols-1 lg:grid-cols-2 gap-6">
              {/* Recent reviews */}
              <div className="bg-base-100 rounded-2xl border border-base-200 overflow-hidden">
                <div className="flex items-center justify-between px-5 py-4 border-b border-base-200">
                  <h3 className="font-semibold text-base-content text-sm">Avis récents</h3>
                  <Link to="/admin/reviews" className="text-xs text-primary hover:underline">Voir tout</Link>
                </div>
                <div className="overflow-x-auto">
                  <table className="table table-sm">
                    <thead className="bg-base-200/50">
                      <tr>
                        <th className="text-xs font-medium text-base-content/50">Utilisateur</th>
                        <th className="text-xs font-medium text-base-content/50">Entreprise</th>
                        <th className="text-xs font-medium text-base-content/50">Note</th>
                        <th className="text-xs font-medium text-base-content/50">Statut</th>
                      </tr>
                    </thead>
                    <tbody>
                      {stats.recentReviews.map((review) => (
                        <tr key={review.id} className="hover:bg-base-200/30">
                          <td className="text-sm font-medium">{review.user.username}</td>
                          <td className="text-xs text-base-content/60 max-w-[100px] truncate">{review.company.name}</td>
                          <td>
                            <div className="flex items-center gap-1">
                              <Star size={11} className="text-warning" fill="currentColor" />
                              <span className="text-xs font-semibold">{review.rating}</span>
                            </div>
                          </td>
                          <td>
                            <span className={`badge badge-xs font-medium ${
                              review.status === 'APPROVED' ? 'badge-success' :
                              review.status === 'PENDING' ? 'badge-warning' : 'badge-error'
                            }`}>
                              {review.status === 'APPROVED' ? 'Approuvé' : review.status === 'PENDING' ? 'En attente' : 'Rejeté'}
                            </span>
                          </td>
                        </tr>
                      ))}
                      {stats.recentReviews.length === 0 && (
                        <tr><td colSpan={4} className="text-center text-xs text-base-content/40 py-6">Aucun avis récent</td></tr>
                      )}
                    </tbody>
                  </table>
                </div>
              </div>

              {/* Recent users */}
              <div className="bg-base-100 rounded-2xl border border-base-200 overflow-hidden">
                <div className="flex items-center justify-between px-5 py-4 border-b border-base-200">
                  <h3 className="font-semibold text-base-content text-sm">Utilisateurs récents</h3>
                  <Link to="/admin/users" className="text-xs text-primary hover:underline">Voir tout</Link>
                </div>
                <div className="overflow-x-auto">
                  <table className="table table-sm">
                    <thead className="bg-base-200/50">
                      <tr>
                        <th className="text-xs font-medium text-base-content/50">Utilisateur</th>
                        <th className="text-xs font-medium text-base-content/50">Email</th>
                        <th className="text-xs font-medium text-base-content/50">Rôle</th>
                      </tr>
                    </thead>
                    <tbody>
                      {stats.recentUsers.map((u) => (
                        <tr key={u.id} className="hover:bg-base-200/30">
                          <td>
                            <div className="flex items-center gap-2">
                              <div className="w-7 h-7 rounded-full bg-primary/15 flex items-center justify-center text-primary font-bold text-xs uppercase">
                                {u.username[0]}
                              </div>
                              <span className="text-sm font-medium">{u.username}</span>
                            </div>
                          </td>
                          <td className="text-xs text-base-content/50 max-w-[120px] truncate">{u.email}</td>
                          <td>
                            <span className={`badge badge-xs font-medium ${
                              u.role === 'ADMIN' ? 'badge-error' :
                              u.role === 'MODERATOR' ? 'badge-warning' : 'badge-info'
                            }`}>
                              {u.role}
                            </span>
                          </td>
                        </tr>
                      ))}
                      {stats.recentUsers.length === 0 && (
                        <tr><td colSpan={3} className="text-center text-xs text-base-content/40 py-6">Aucun utilisateur récent</td></tr>
                      )}
                    </tbody>
                  </table>
                </div>
              </div>
            </div>
          )}
        </main>
      </div>
    </div>
  );
}

export default AdminDashboard;
