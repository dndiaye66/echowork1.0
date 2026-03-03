import { useEffect } from 'react';
import { useNavigate } from 'react-router-dom';
import { useAuth } from '../contexts/AuthContext';

function AuthCallback() {
  const navigate = useNavigate();
  const { login } = useAuth();

  useEffect(() => {
    const params = new URLSearchParams(window.location.search);
    const token = params.get('token');
    const userRaw = params.get('user');

    if (token && userRaw) {
      try {
        const user = JSON.parse(userRaw);
        login(user, token);
        navigate('/', { replace: true });
      } catch {
        navigate('/login?error=google', { replace: true });
      }
    } else {
      navigate('/login?error=google', { replace: true });
    }
  }, []);

  return (
    <div className="min-h-screen flex items-center justify-center bg-gray-50">
      <div className="text-center">
        <div className="loading loading-spinner loading-lg text-red-600 mb-4" />
        <p className="text-gray-500">Connexion en cours...</p>
      </div>
    </div>
  );
}

export default AuthCallback;
