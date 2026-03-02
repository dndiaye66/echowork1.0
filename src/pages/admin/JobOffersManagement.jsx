import { useState, useEffect } from 'react';
import axios from '../../api/Config';
import AdminLayout from '../../components/AdminLayout';

function JobOffersManagement() {
  const [jobOffers, setJobOffers] = useState([]);
  const [companies, setCompanies] = useState([]);
  const [loading, setLoading] = useState(true);
  const [showForm, setShowForm] = useState(false);
  const [editingId, setEditingId] = useState(null);
  const [formData, setFormData] = useState({
    title: '',
    description: '',
    salary: '',
    location: '',
    companyId: '',
    isActive: true,
  });

  useEffect(() => {
    fetchData();
  }, []);

  const fetchData = async () => {
    try {
      const [jobOffersRes, companiesRes] = await Promise.all([
        axios.get('/admin/job-offers'),
        axios.get('/companies'),
      ]);
      setJobOffers(jobOffersRes.data);
      setCompanies(companiesRes.data);
    } catch (error) {
      console.error('Failed to fetch data:', error);
      alert('Failed to load data');
    } finally {
      setLoading(false);
    }
  };

  const handleSubmit = async (e) => {
    e.preventDefault();
    try {
      const data = {
        ...formData,
        companyId: parseInt(formData.companyId),
      };

      if (editingId) {
        await axios.put(`/admin/job-offers/${editingId}`, data);
        alert('Job offer updated successfully');
      } else {
        await axios.post('/admin/job-offers', data);
        alert('Job offer created successfully');
      }

      setShowForm(false);
      setEditingId(null);
      setFormData({ title: '', description: '', salary: '', location: '', companyId: '', isActive: true });
      fetchData();
    } catch (error) {
      console.error('Failed to save job offer:', error);
      alert(error.response?.data?.message || 'Failed to save job offer');
    }
  };

  const handleEdit = (jobOffer) => {
    setFormData({
      title: jobOffer.title,
      description: jobOffer.description,
      salary: jobOffer.salary || '',
      location: jobOffer.location || '',
      companyId: jobOffer.companyId.toString(),
      isActive: jobOffer.isActive,
    });
    setEditingId(jobOffer.id);
    setShowForm(true);
  };

  const handleDelete = async (id) => {
    if (!confirm('Are you sure you want to delete this job offer?')) return;

    try {
      await axios.delete(`/admin/job-offers/${id}`);
      alert('Job offer deleted successfully');
      fetchData();
    } catch (error) {
      console.error('Failed to delete job offer:', error);
      alert(error.response?.data?.message || 'Failed to delete job offer');
    }
  };

  if (loading) {
    return (
      <AdminLayout title="Offres d'emploi">
        <div className="flex items-center justify-center h-64">
          <div className="loading loading-spinner loading-lg"></div>
        </div>
      </AdminLayout>
    );
  }

  return (
    <AdminLayout title="Offres d'emploi">
      <div className="flex justify-between items-center mb-8">
        <h1 className="text-4xl font-bold">Job Offers Management</h1>
        <button
          className="btn btn-primary"
          onClick={() => {
            setShowForm(true);
            setEditingId(null);
            setFormData({ title: '', description: '', salary: '', location: '', companyId: '', isActive: true });
          }}
        >
          Add New Job Offer
        </button>
      </div>

      {showForm && (
        <div className="card bg-base-100 shadow-xl mb-8">
          <div className="card-body">
            <h2 className="card-title">{editingId ? 'Edit' : 'Add'} Job Offer</h2>
            <form onSubmit={handleSubmit}>
              <div className="form-control mb-4">
                <label className="label">
                  <span className="label-text">Title *</span>
                </label>
                <input
                  type="text"
                  className="input input-bordered"
                  value={formData.title}
                  onChange={(e) => setFormData({ ...formData, title: e.target.value })}
                  required
                />
              </div>

              <div className="form-control mb-4">
                <label className="label">
                  <span className="label-text">Description *</span>
                </label>
                <textarea
                  className="textarea textarea-bordered"
                  value={formData.description}
                  onChange={(e) => setFormData({ ...formData, description: e.target.value })}
                  rows={4}
                  required
                />
              </div>

              <div className="form-control mb-4">
                <label className="label">
                  <span className="label-text">Salary</span>
                </label>
                <input
                  type="text"
                  className="input input-bordered"
                  value={formData.salary}
                  onChange={(e) => setFormData({ ...formData, salary: e.target.value })}
                />
              </div>

              <div className="form-control mb-4">
                <label className="label">
                  <span className="label-text">Location</span>
                </label>
                <input
                  type="text"
                  className="input input-bordered"
                  value={formData.location}
                  onChange={(e) => setFormData({ ...formData, location: e.target.value })}
                />
              </div>

              <div className="form-control mb-4">
                <label className="label">
                  <span className="label-text">Company *</span>
                </label>
                <select
                  className="select select-bordered"
                  value={formData.companyId}
                  onChange={(e) => setFormData({ ...formData, companyId: e.target.value })}
                  required
                >
                  <option value="">Select a company</option>
                  {companies.map((company) => (
                    <option key={company.id} value={company.id}>
                      {company.name}
                    </option>
                  ))}
                </select>
              </div>

              <div className="form-control mb-4">
                <label className="cursor-pointer label justify-start gap-2">
                  <input
                    type="checkbox"
                    className="checkbox"
                    checked={formData.isActive}
                    onChange={(e) => setFormData({ ...formData, isActive: e.target.checked })}
                  />
                  <span className="label-text">Active</span>
                </label>
              </div>

              <div className="flex gap-2">
                <button type="submit" className="btn btn-primary">
                  {editingId ? 'Update' : 'Create'}
                </button>
                <button
                  type="button"
                  className="btn btn-ghost"
                  onClick={() => {
                    setShowForm(false);
                    setEditingId(null);
                  }}
                >
                  Cancel
                </button>
              </div>
            </form>
          </div>
        </div>
      )}

      <div className="overflow-x-auto">
        <table className="table w-full bg-base-100">
          <thead>
            <tr>
              <th>Title</th>
              <th>Company</th>
              <th>Location</th>
              <th>Salary</th>
              <th>Status</th>
              <th>Actions</th>
            </tr>
          </thead>
          <tbody>
            {jobOffers.map((job) => (
              <tr key={job.id}>
                <td>{job.title}</td>
                <td>{job.company?.name}</td>
                <td>{job.location || '-'}</td>
                <td>{job.salary || '-'}</td>
                <td>
                  <span className={`badge ${job.isActive ? 'badge-success' : 'badge-error'}`}>
                    {job.isActive ? 'Active' : 'Inactive'}
                  </span>
                </td>
                <td>
                  <button
                    className="btn btn-sm btn-info mr-2"
                    onClick={() => handleEdit(job)}
                  >
                    Edit
                  </button>
                  <button
                    className="btn btn-sm btn-error"
                    onClick={() => handleDelete(job.id)}
                  >
                    Delete
                  </button>
                </td>
              </tr>
            ))}
          </tbody>
        </table>
      </div>
    </AdminLayout>
  );
}

export default JobOffersManagement;
