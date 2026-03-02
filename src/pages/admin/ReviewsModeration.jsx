import { useEffect, useState } from 'react';
import AdminLayout from '../../components/AdminLayout';
import axios from '../../api/Config';
import { CheckCircle, XCircle, Star, MessageSquare, Clock } from 'lucide-react';

function ReviewsModeration() {
  const [reviews, setReviews] = useState([]);
  const [loading, setLoading] = useState(true);

  const fetchPendingReviews = async () => {
    try {
      const response = await axios.get('/admin/reviews/pending');
      setReviews(response.data);
    } catch (err) {
      console.error('Failed to fetch pending reviews:', err);
    } finally {
      setLoading(false);
    }
  };

  useEffect(() => { fetchPendingReviews(); }, []);

  const handleApprove = async (reviewId) => {
    // Optimistic removal
    setReviews((prev) => prev.filter((r) => r.id !== reviewId));
    try {
      await axios.put(`/admin/reviews/${reviewId}/approve`);
    } catch (err) {
      console.error('Failed to approve review:', err);
      // Re-fetch on error to restore state
      fetchPendingReviews();
    }
  };

  const handleReject = async (reviewId) => {
    if (!confirm('Rejeter cet avis ?')) return;
    // Optimistic removal
    setReviews((prev) => prev.filter((r) => r.id !== reviewId));
    try {
      await axios.put(`/admin/reviews/${reviewId}/reject`);
    } catch (err) {
      console.error('Failed to reject review:', err);
      fetchPendingReviews();
    }
  };

  if (loading) {
    return (
      <AdminLayout title="Modération des avis">
        <div className="flex items-center justify-center h-64">
          <span className="loading loading-spinner loading-lg" />
        </div>
      </AdminLayout>
    );
  }

  return (
    <AdminLayout title="Modération des avis">
      {/* Stats bar */}
      <div className="flex items-center gap-3 mb-6">
        <div className="flex items-center gap-2 px-4 py-2 rounded-xl bg-base-100 shadow-sm border border-base-200">
          <Clock size={15} className="text-warning" />
          <span className="text-sm font-semibold">{reviews.length}</span>
          <span className="text-sm text-base-content/50">
            avis en attente
          </span>
        </div>
      </div>

      {/* Empty state */}
      {reviews.length === 0 ? (
        <div className="card bg-base-100 shadow-sm">
          <div className="card-body items-center text-center py-16">
            <CheckCircle size={56} className="text-success mb-3 opacity-80" />
            <h2 className="text-lg font-bold">Aucun avis en attente</h2>
            <p className="text-base-content/50 text-sm mt-1">
              Modération à jour !
            </p>
          </div>
        </div>
      ) : (
        <div className="space-y-4">
          {reviews.map((review) => (
            <div key={review.id} className="card bg-base-100 shadow-sm border border-base-200">
              <div className="card-body p-5">
                <div className="flex flex-col sm:flex-row sm:items-start gap-4">
                  {/* Main content */}
                  <div className="flex-1 min-w-0">
                    {/* Company + category */}
                    <div className="flex flex-wrap items-center gap-2 mb-2">
                      <h2 className="font-bold text-base leading-none">
                        {review.company?.name}
                      </h2>
                      {review.company?.category?.name && (
                        <span className="badge badge-sm badge-ghost">
                          {review.company.category.name}
                        </span>
                      )}
                    </div>

                    {/* Star rating */}
                    <div className="flex items-center gap-1.5 mb-3">
                      <div className="flex items-center">
                        {[1, 2, 3, 4, 5].map((i) => (
                          <Star
                            key={i}
                            size={16}
                            className={
                              i <= review.rating
                                ? 'fill-yellow-400 text-yellow-400'
                                : 'text-base-200 fill-base-200'
                            }
                          />
                        ))}
                      </div>
                      <span className="text-sm font-semibold text-base-content/70">
                        {review.rating}/5
                      </span>
                    </div>

                    {/* Comment */}
                    <p className="text-sm text-base-content/80 line-clamp-3 mb-3">
                      {review.comment}
                    </p>

                    {/* Reviewer info */}
                    <div className="flex flex-wrap items-center gap-3 text-xs text-base-content/50">
                      <div className="flex items-center gap-1">
                        <MessageSquare size={11} />
                        <span className="font-medium text-base-content/70">
                          {review.user?.username}
                        </span>
                        {review.user?.email && (
                          <span>({review.user.email})</span>
                        )}
                      </div>
                      {review.context && (
                        <span className="badge badge-xs badge-ghost">{review.context}</span>
                      )}
                      {review.createdAt && (
                        <span>
                          {new Date(review.createdAt).toLocaleDateString('fr-FR', {
                            day: '2-digit',
                            month: 'short',
                            year: 'numeric',
                          })}
                        </span>
                      )}
                    </div>

                    {/* Votes */}
                    {(review.upvotes > 0 || review.downvotes > 0) && (
                      <div className="flex items-center gap-2 text-xs mt-2">
                        <span className="text-success font-medium">↑ {review.upvotes}</span>
                        <span className="text-base-content/30">/</span>
                        <span className="text-error font-medium">↓ {review.downvotes}</span>
                      </div>
                    )}
                  </div>

                  {/* Actions */}
                  <div className="flex sm:flex-col gap-2 shrink-0">
                    <button
                      className="btn btn-success btn-sm gap-1.5 flex-1 sm:flex-none"
                      onClick={() => handleApprove(review.id)}
                    >
                      <CheckCircle size={15} />
                      Approuver
                    </button>
                    <button
                      className="btn btn-error btn-sm btn-outline gap-1.5 flex-1 sm:flex-none"
                      onClick={() => handleReject(review.id)}
                    >
                      <XCircle size={15} />
                      Rejeter
                    </button>
                  </div>
                </div>
              </div>
            </div>
          ))}
        </div>
      )}
    </AdminLayout>
  );
}

export default ReviewsModeration;
