import { useEffect, useState } from 'react';
import axios from '../../api/Config';
import AdminLayout from '../../components/AdminLayout';
import {
  TrendingUp,
  Users,
  Building2,
  MessageSquare,
  Clock,
  ThumbsUp,
  ThumbsDown,
  Star,
  Download,
} from 'lucide-react';

function StarRow({ rating }) {
  return (
    <span className="flex gap-0.5">
      {[1, 2, 3, 4, 5].map((s) => (
        <Star
          key={s}
          size={12}
          className={s <= rating ? 'text-red-500 fill-red-500' : 'text-gray-200 fill-gray-200'}
        />
      ))}
    </span>
  );
}

function KpiCard({ icon: Icon, label, value, color }) {
  return (
    <div className="bg-white rounded-2xl shadow-sm border border-gray-100 p-5 flex items-center gap-4">
      <div className={`w-12 h-12 rounded-xl flex items-center justify-center ${color}`}>
        <Icon size={22} className="text-white" />
      </div>
      <div>
        <p className="text-sm text-gray-500">{label}</p>
        <p className="text-2xl font-bold text-gray-900">{value ?? '—'}</p>
      </div>
    </div>
  );
}

function ReviewTable({ reviews, emptyMsg }) {
  if (!reviews?.length) {
    return <p className="text-sm text-gray-400 py-4 text-center">{emptyMsg}</p>;
  }
  return (
    <div className="overflow-x-auto">
      <table className="w-full text-sm">
        <thead>
          <tr className="border-b border-gray-100 text-left text-gray-500 text-xs uppercase">
            <th className="pb-2 pr-3 font-medium">Utilisateur</th>
            <th className="pb-2 pr-3 font-medium">Entreprise</th>
            <th className="pb-2 pr-3 font-medium">Note</th>
            <th className="pb-2 pr-3 font-medium">Commentaire</th>
            <th className="pb-2 pr-3 font-medium">👍 / 👎</th>
          </tr>
        </thead>
        <tbody>
          {reviews.map((r) => (
            <tr key={r.id} className="border-b border-gray-50 hover:bg-gray-50 transition-colors">
              <td className="py-2.5 pr-3 font-medium text-gray-800">{r.user?.username}</td>
              <td className="py-2.5 pr-3 text-gray-600">{r.company?.name}</td>
              <td className="py-2.5 pr-3">
                <StarRow rating={r.rating} />
              </td>
              <td className="py-2.5 pr-3 text-gray-500 max-w-xs truncate">
                {r.comment || <span className="italic text-gray-300">—</span>}
              </td>
              <td className="py-2.5 pr-3 text-xs text-gray-500 whitespace-nowrap">
                <span className="text-green-600 font-medium">+{r.upvotes}</span>
                {' / '}
                <span className="text-red-500 font-medium">-{r.downvotes}</span>
              </td>
            </tr>
          ))}
        </tbody>
      </table>
    </div>
  );
}

function AnalyticsPage() {
  const [loading, setLoading] = useState(true);
  const [overview, setOverview] = useState(null);
  const [error, setError] = useState(null);

  useEffect(() => {
    fetchOverview();
  }, []);

  const fetchOverview = async () => {
    try {
      setLoading(true);
      setError(null);
      const { data } = await axios.get('/admin/analytics/overview');
      setOverview(data);
    } catch (err) {
      console.error('Failed to fetch analytics:', err);
      setError('Impossible de charger les données analytiques.');
    } finally {
      setLoading(false);
    }
  };

  const handleExport = async (type) => {
    try {
      const { data } = await axios.get(`/admin/export/${type}`);
      if (!data?.length) return;
      const headers = Object.keys(data[0]);
      const csv = [
        headers.join(','),
        ...data.map((row) =>
          headers.map((h) => `"${String(row[h] ?? '').replace(/"/g, '""')}"`).join(',')
        ),
      ].join('\n');
      const blob = new Blob([csv], { type: 'text/csv' });
      const url = URL.createObjectURL(blob);
      const a = document.createElement('a');
      a.href = url;
      a.download = `${type}-${new Date().toISOString().split('T')[0]}.csv`;
      document.body.appendChild(a);
      a.click();
      document.body.removeChild(a);
      URL.revokeObjectURL(url);
    } catch (err) {
      console.error(`Export ${type} failed`, err);
    }
  };

  if (loading) {
    return (
      <AdminLayout title="Analytiques">
        <div className="flex items-center justify-center h-64">
          <div className="loading loading-spinner loading-lg text-red-600" />
        </div>
      </AdminLayout>
    );
  }

  if (error) {
    return (
      <AdminLayout title="Analytiques">
        <div className="alert alert-error">{error}</div>
      </AdminLayout>
    );
  }

  const { kpis, recentReviews, topLiked, topDisliked } = overview;

  return (
    <AdminLayout title="Analytiques">
      {/* Header */}
      <div className="flex flex-col sm:flex-row sm:items-center justify-between gap-4 mb-8">
        <div className="flex items-center gap-3">
          <div className="w-10 h-10 bg-red-600 rounded-xl flex items-center justify-center">
            <TrendingUp size={20} className="text-white" />
          </div>
          <div>
            <h1 className="text-2xl font-bold text-gray-900">Tableau de bord analytique</h1>
            <p className="text-sm text-gray-500">Vue d'ensemble de la plateforme</p>
          </div>
        </div>
        <div className="flex gap-2">
          {['users', 'companies', 'reviews'].map((type) => (
            <button
              key={type}
              onClick={() => handleExport(type)}
              className="btn btn-sm btn-outline gap-1 border-gray-200 text-gray-600 hover:border-gray-300"
            >
              <Download size={14} />
              {type === 'users' ? 'Utilisateurs' : type === 'companies' ? 'Entreprises' : 'Avis'}
            </button>
          ))}
        </div>
      </div>

      {/* KPI Cards */}
      <div className="grid grid-cols-1 sm:grid-cols-2 xl:grid-cols-4 gap-4 mb-8">
        <KpiCard
          icon={Building2}
          label="Entreprises"
          value={kpis.totalCompanies}
          color="bg-blue-500"
        />
        <KpiCard
          icon={Users}
          label="Utilisateurs"
          value={kpis.totalUsers}
          color="bg-purple-500"
        />
        <KpiCard
          icon={MessageSquare}
          label="Avis total"
          value={kpis.totalReviews}
          color="bg-red-600"
        />
        <KpiCard
          icon={Clock}
          label="Avis (24 dernières h)"
          value={kpis.reviewsLast24h}
          color="bg-amber-500"
        />
      </div>

      {/* Recent Reviews */}
      <div className="bg-white rounded-2xl shadow-sm border border-gray-100 p-6 mb-6">
        <h2 className="text-lg font-semibold text-gray-900 flex items-center gap-2 mb-4">
          <MessageSquare size={18} className="text-red-600" />
          10 derniers avis
        </h2>
        <ReviewTable reviews={recentReviews} emptyMsg="Aucun avis pour l'instant." />
      </div>

      {/* Top Liked / Top Disliked */}
      <div className="grid grid-cols-1 lg:grid-cols-2 gap-6">
        <div className="bg-white rounded-2xl shadow-sm border border-gray-100 p-6">
          <h2 className="text-lg font-semibold text-gray-900 flex items-center gap-2 mb-4">
            <ThumbsUp size={18} className="text-green-600" />
            Commentaires les plus aimés
          </h2>
          <ReviewTable reviews={topLiked} emptyMsg="Aucun avis liké pour l'instant." />
        </div>
        <div className="bg-white rounded-2xl shadow-sm border border-gray-100 p-6">
          <h2 className="text-lg font-semibold text-gray-900 flex items-center gap-2 mb-4">
            <ThumbsDown size={18} className="text-red-500" />
            Commentaires les plus dislikés
          </h2>
          <ReviewTable reviews={topDisliked} emptyMsg="Aucun avis disliké pour l'instant." />
        </div>
      </div>
    </AdminLayout>
  );
}

export default AnalyticsPage;
