// src/services/reviewService.jsx
import apiClient from '../api/Config';

export const reviewService = {
  getCompanyReviews: async (companyId, rating = undefined) => {
    const params = rating ? { rating } : {};
    const response = await apiClient.get(`/reviews/company/${companyId}`, { params });
    return response.data;
  },

  createReview: async (reviewData) => {
    const response = await apiClient.post('/reviews', reviewData);
    return response.data;
  },

  updateReview: async (reviewId, reviewData) => {
    const response = await apiClient.patch(`/reviews/${reviewId}`, reviewData);
    return response.data;
  },

  getReviewById: async (reviewId) => {
    const response = await apiClient.get(`/reviews/${reviewId}`);
    return response.data;
  },

  deleteReview: async (reviewId) => {
    const response = await apiClient.delete(`/reviews/${reviewId}`);
    return response.data;
  },
};
