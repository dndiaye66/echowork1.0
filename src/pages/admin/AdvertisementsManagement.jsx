import { useEffect, useState } from 'react';
import AdminLayout from '../../components/AdminLayout';
import axios from '../../api/Config';
import { Plus, Edit2, Trash2, X, Image, Calendar, ToggleLeft, ToggleRight, Eye } from 'lucide-react';

// ─── Ad Modal ─────────────────────────────────────────────────────────────────

function AdModal({ modal, companies, onClose, onSaved }) {
  const isEdit = !!modal.id;
  const initial = modal.data || {};

  const [form, setForm] = useState({
    title: initial.title || '',
    content: initial.content || '',
    imageUrl: initial.imageUrl || '',
    companyId: initial.companyId ? String(initial.companyId) : '',
    startDate: initial.startDate
      ? new Date(initial.startDate).toISOString().split('T')[0]
      : '',
    endDate: initial.endDate
      ? new Date(initial.endDate).toISOString().split('T')[0]
      : '',
    isActive: initial.isActive ?? true,
  });
  const [saving, setSaving] = useState(false);
  const [error, setError] = useState('');

  const handleField = (field, value) => {
    setForm((prev) => ({ ...prev, [field]: value }));
  };

  const handleSave = async (e) => {
    e.preventDefault();
    setError('');
    setSaving(true);
    try {
      const payload = {
        ...form,
        companyId: form.companyId ? parseInt(form.companyId) : undefined,
        startDate: form.startDate ? new Date(form.startDate).toISOString() : undefined,
        endDate: form.endDate ? new Date(form.endDate).toISOString() : undefined,
      };
      if (isEdit) {
        await axios.put(`/admin/advertisements/${modal.id}`, payload);
      } else {
        await axios.post('/admin/advertisements', payload);
      }
      onSaved();
    } catch (err) {
      setError(err.response?.data?.message || 'Erreur lors de la sauvegarde');
    } finally {
      setSaving(false);
    }
  };

  return (
    <div className="modal modal-open">
      <div className="modal-box w-11/12 max-w-3xl">
        <div className="flex items-center justify-between mb-4">
          <h3 className="font-bold text-lg">
            {isEdit ? 'Modifier la publicité' : 'Nouvelle publicité'}
          </h3>
          <button className="btn btn-ghost btn-sm btn-square" onClick={onClose}>
            <X size={16} />
          </button>
        </div>

        {error && (
          <div className="alert alert-error mb-4 text-sm">{error}</div>
        )}

        <div className="grid grid-cols-1 lg:grid-cols-2 gap-6">
          {/* Form */}
          <form onSubmit={handleSave} className="space-y-3">
            <div className="form-control">
              <label className="label py-1">
                <span className="label-text text-xs font-medium">Titre *</span>
              </label>
              <input
                type="text"
                className="input input-bordered input-sm"
                value={form.title}
                onChange={(e) => handleField('title', e.target.value)}
                required
              />
            </div>

            <div className="form-control">
              <label className="label py-1">
                <span className="label-text text-xs font-medium">Contenu *</span>
              </label>
              <textarea
                className="textarea textarea-bordered textarea-sm"
                rows={4}
                value={form.content}
                onChange={(e) => handleField('content', e.target.value)}
                required
              />
            </div>

            <div className="form-control">
              <label className="label py-1">
                <span className="label-text text-xs font-medium">URL de l'image</span>
              </label>
              <input
                type="text"
                className="input input-bordered input-sm"
                value={form.imageUrl}
                onChange={(e) => handleField('imageUrl', e.target.value)}
                placeholder="https://..."
              />
            </div>

            <div className="form-control">
              <label className="label py-1">
                <span className="label-text text-xs font-medium">Entreprise (optionnel)</span>
              </label>
              <select
                className="select select-bordered select-sm"
                value={form.companyId}
                onChange={(e) => handleField('companyId', e.target.value)}
              >
                <option value="">Aucune (publicité générale)</option>
                {companies.map((c) => (
                  <option key={c.id} value={c.id}>{c.name}</option>
                ))}
              </select>
            </div>

            <div className="grid grid-cols-2 gap-3">
              <div className="form-control">
                <label className="label py-1">
                  <span className="label-text text-xs font-medium">Date de début *</span>
                </label>
                <input
                  type="date"
                  className="input input-bordered input-sm"
                  value={form.startDate}
                  onChange={(e) => handleField('startDate', e.target.value)}
                  required
                />
              </div>
              <div className="form-control">
                <label className="label py-1">
                  <span className="label-text text-xs font-medium">Date de fin *</span>
                </label>
                <input
                  type="date"
                  className="input input-bordered input-sm"
                  value={form.endDate}
                  onChange={(e) => handleField('endDate', e.target.value)}
                  required
                />
              </div>
            </div>

            <div className="form-control">
              <label className="label cursor-pointer justify-start gap-3 py-1">
                <input
                  type="checkbox"
                  className="checkbox checkbox-sm checkbox-success"
                  checked={form.isActive}
                  onChange={(e) => handleField('isActive', e.target.checked)}
                />
                <span className="label-text text-xs font-medium">Active</span>
              </label>
            </div>

            <div className="modal-action pt-2">
              <button type="button" className="btn btn-ghost btn-sm" onClick={onClose}>
                Annuler
              </button>
              <button type="submit" className="btn btn-primary btn-sm" disabled={saving}>
                {saving && <span className="loading loading-spinner loading-xs" />}
                {isEdit ? 'Enregistrer' : 'Créer'}
              </button>
            </div>
          </form>

          {/* Live preview */}
          <div>
            <p className="text-xs font-medium text-base-content/50 uppercase tracking-wide mb-2">
              Aperçu
            </p>
            <div className="card bg-base-200 shadow-sm overflow-hidden">
              {form.imageUrl ? (
                <figure className="h-36 overflow-hidden bg-base-300">
                  <img
                    src={form.imageUrl}
                    alt="preview"
                    className="w-full h-full object-cover"
                    onError={(e) => { e.target.style.display = 'none'; }}
                  />
                </figure>
              ) : (
                <div className="h-36 bg-base-300 flex items-center justify-center">
                  <Image size={32} className="text-base-content/20" />
                </div>
              )}
              <div className="card-body p-4">
                <h4 className="font-bold text-sm leading-snug">
                  {form.title || <span className="text-base-content/30 italic">Titre de la publicité</span>}
                </h4>
                <p className="text-xs text-base-content/60 line-clamp-3 mt-1">
                  {form.content || <span className="italic">Contenu de la publicité…</span>}
                </p>
                {(form.startDate || form.endDate) && (
                  <div className="flex items-center gap-1 text-xs text-base-content/40 mt-2">
                    <Calendar size={11} />
                    <span>
                      {form.startDate || '?'} → {form.endDate || '?'}
                    </span>
                  </div>
                )}
              </div>
            </div>
          </div>
        </div>
      </div>
      <div className="modal-backdrop" onClick={onClose} />
    </div>
  );
}

// ─── Main Page ────────────────────────────────────────────────────────────────

function AdvertisementsManagement() {
  const [advertisements, setAdvertisements] = useState([]);
  const [companies, setCompanies] = useState([]);
  const [loading, setLoading] = useState(true);
  const [modal, setModal] = useState(null); // null | { data, id }
  const [preview, setPreview] = useState(null); // null | ad object

  const fetchAll = async () => {
    try {
      const [adsRes, companiesRes] = await Promise.all([
        axios.get('/admin/advertisements'),
        axios.get('/companies'),
      ]);
      setAdvertisements(adsRes.data);
      setCompanies(companiesRes.data);
    } catch (err) {
      console.error('Erreur chargement:', err);
    } finally {
      setLoading(false);
    }
  };

  useEffect(() => { fetchAll(); }, []);

  const handleDelete = async (id) => {
    if (!confirm('Supprimer cette publicité ?')) return;
    try {
      await axios.delete(`/admin/advertisements/${id}`);
      setAdvertisements((prev) => prev.filter((a) => a.id !== id));
      if (preview?.id === id) setPreview(null);
    } catch (err) {
      alert(err.response?.data?.message || 'Erreur lors de la suppression');
    }
  };

  const handleToggleActive = async (ad) => {
    try {
      await axios.put(`/admin/advertisements/${ad.id}`, { isActive: !ad.isActive });
      setAdvertisements((prev) =>
        prev.map((a) => a.id === ad.id ? { ...a, isActive: !a.isActive } : a)
      );
    } catch (err) {
      alert(err.response?.data?.message || 'Erreur');
    }
  };

  const openCreate = () => setModal({ data: null, id: null });
  const openEdit = (ad) => setModal({ data: ad, id: ad.id });
  const closeModal = () => setModal(null);
  const onSaved = () => { closeModal(); fetchAll(); };

  const statusBadge = (ad) => {
    const now = new Date();
    const end = ad.endDate ? new Date(ad.endDate) : null;
    if (end && end < now) return { label: 'Terminée', cls: 'badge-ghost' };
    if (!ad.isActive) return { label: 'En pause', cls: 'badge-warning' };
    return { label: 'Active', cls: 'badge-success' };
  };

  if (loading) {
    return (
      <AdminLayout title="Publicités">
        <div className="flex items-center justify-center h-64">
          <span className="loading loading-spinner loading-lg" />
        </div>
      </AdminLayout>
    );
  }

  return (
    <AdminLayout title="Publicités">
      <div className="flex items-center justify-between mb-6">
        <p className="text-sm text-base-content/50">{advertisements.length} publicité{advertisements.length !== 1 ? 's' : ''}</p>
        <button className="btn btn-primary btn-sm gap-2" onClick={openCreate}>
          <Plus size={15} />
          Ajouter
        </button>
      </div>

      <div className={`grid gap-6 ${preview ? 'grid-cols-1 xl:grid-cols-3' : 'grid-cols-1'}`}>
        {/* Table */}
        <div className={preview ? 'xl:col-span-2' : ''}>
          <div className="card bg-base-100 shadow-sm overflow-hidden">
            <div className="overflow-x-auto">
              <table className="table table-sm">
                <thead>
                  <tr className="text-xs text-base-content/50 uppercase tracking-wide">
                    <th>Aperçu</th>
                    <th>Titre / Contenu</th>
                    <th>Entreprise</th>
                    <th>Dates</th>
                    <th>Statut</th>
                    <th>Actions</th>
                  </tr>
                </thead>
                <tbody>
                  {advertisements.length === 0 && (
                    <tr>
                      <td colSpan={6} className="text-center py-10 text-base-content/40">
                        Aucune publicité
                      </td>
                    </tr>
                  )}
                  {advertisements.map((ad) => {
                    const { label, cls } = statusBadge(ad);
                    return (
                      <tr key={ad.id} className="hover">
                        <td>
                          {ad.imageUrl ? (
                            <img
                              src={ad.imageUrl}
                              alt={ad.title}
                              className="w-12 h-9 rounded object-cover bg-base-200"
                            />
                          ) : (
                            <div className="w-12 h-9 rounded bg-base-200 flex items-center justify-center">
                              <Image size={14} className="text-base-content/20" />
                            </div>
                          )}
                        </td>
                        <td>
                          <p className="font-semibold text-sm leading-none">{ad.title}</p>
                          <p className="text-xs text-base-content/50 line-clamp-1 mt-0.5">
                            {ad.content}
                          </p>
                        </td>
                        <td className="text-sm">
                          {ad.company?.name || (
                            <span className="text-base-content/30 text-xs italic">Générale</span>
                          )}
                        </td>
                        <td>
                          <div className="flex items-center gap-1 text-xs text-base-content/60 whitespace-nowrap">
                            <Calendar size={11} />
                            <span>
                              {ad.startDate ? new Date(ad.startDate).toLocaleDateString('fr-FR') : '?'}
                              {' → '}
                              {ad.endDate ? new Date(ad.endDate).toLocaleDateString('fr-FR') : '?'}
                            </span>
                          </div>
                        </td>
                        <td>
                          <span className={`badge badge-sm ${cls}`}>{label}</span>
                        </td>
                        <td>
                          <div className="flex items-center gap-1">
                            <button
                              className="btn btn-ghost btn-xs"
                              onClick={() => setPreview(preview?.id === ad.id ? null : ad)}
                              title="Aperçu"
                            >
                              <Eye size={13} />
                            </button>
                            <button
                              className="btn btn-ghost btn-xs"
                              onClick={() => handleToggleActive(ad)}
                              title={ad.isActive ? 'Mettre en pause' : 'Activer'}
                            >
                              {ad.isActive
                                ? <ToggleRight size={14} className="text-success" />
                                : <ToggleLeft size={14} className="text-base-content/40" />}
                            </button>
                            <button
                              className="btn btn-ghost btn-xs"
                              onClick={() => openEdit(ad)}
                              title="Modifier"
                            >
                              <Edit2 size={13} />
                            </button>
                            <button
                              className="btn btn-ghost btn-xs text-error"
                              onClick={() => handleDelete(ad.id)}
                              title="Supprimer"
                            >
                              <Trash2 size={13} />
                            </button>
                          </div>
                        </td>
                      </tr>
                    );
                  })}
                </tbody>
              </table>
            </div>
          </div>
        </div>

        {/* Preview panel */}
        {preview && (
          <div className="xl:col-span-1">
            <div className="card bg-base-100 shadow-sm sticky top-0">
              <div className="flex items-center justify-between px-4 pt-4 pb-2">
                <p className="text-xs font-semibold text-base-content/50 uppercase tracking-wide">
                  Aperçu
                </p>
                <button
                  className="btn btn-ghost btn-xs btn-square"
                  onClick={() => setPreview(null)}
                >
                  <X size={13} />
                </button>
              </div>
              {preview.imageUrl ? (
                <figure className="h-40 overflow-hidden bg-base-200">
                  <img
                    src={preview.imageUrl}
                    alt={preview.title}
                    className="w-full h-full object-cover"
                  />
                </figure>
              ) : (
                <div className="h-40 bg-base-200 flex items-center justify-center">
                  <Image size={32} className="text-base-content/20" />
                </div>
              )}
              <div className="card-body p-4">
                <h4 className="font-bold text-base">{preview.title}</h4>
                <p className="text-sm text-base-content/70 mt-1">{preview.content}</p>
                {preview.company && (
                  <p className="text-xs text-primary font-medium mt-2">{preview.company.name}</p>
                )}
                <div className="flex items-center gap-1 text-xs text-base-content/40 mt-2">
                  <Calendar size={11} />
                  <span>
                    {preview.startDate ? new Date(preview.startDate).toLocaleDateString('fr-FR') : '?'}
                    {' → '}
                    {preview.endDate ? new Date(preview.endDate).toLocaleDateString('fr-FR') : '?'}
                  </span>
                </div>
              </div>
            </div>
          </div>
        )}
      </div>

      {/* Modal */}
      {modal && (
        <AdModal
          modal={modal}
          companies={companies}
          onClose={closeModal}
          onSaved={onSaved}
        />
      )}
    </AdminLayout>
  );
}

export default AdvertisementsManagement;
