import { Navigate, useLocation } from 'react-router-dom';
import { useAuth } from '../contexts/AuthContext';

/**
 * Protège une route selon l'authentification et le rôle.
 *
 * Usage :
 *   <ProtectedRoute>                         → connexion requise
 *   <ProtectedRoute allowedRoles={['ADMIN']} → rôle ADMIN uniquement
 *
 * Si non connecté → redirige vers /login en passant l'URL actuelle dans state.from
 * Si connecté mais rôle insuffisant → redirige vers /
 */
export default function ProtectedRoute({ children, allowedRoles = [] }) {
  const { isAuthenticated, user, loading } = useAuth();
  const location = useLocation();

  if (loading) {
    return (
      <div className="flex items-center justify-center min-h-screen bg-gray-50">
        <span className="loading loading-spinner loading-lg text-red-600" />
      </div>
    );
  }

  if (!isAuthenticated) {
    return <Navigate to="/login" state={{ from: location.pathname }} replace />;
  }

  if (allowedRoles.length > 0 && !allowedRoles.includes(user?.role)) {
    return <Navigate to="/" replace />;
  }

  return children;
}
