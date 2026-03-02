import React, { useState, useEffect, useRef } from 'react';
import { Search, Star, MapPin } from 'lucide-react';
import { useNavigate } from 'react-router-dom';
import { companyService } from '../services/companyService';

// variant="dark"  → héro (fond sombre, texte blanc)
// variant="light" → navbar (fond blanc, texte gris foncé, compact)
const SearchAutocomplete = ({ placeholder = "Rechercher une entreprise...", variant = 'dark' }) => {
  const [query, setQuery] = useState('');
  const [results, setResults] = useState([]);
  const [loading, setLoading] = useState(false);
  const [showDropdown, setShowDropdown] = useState(false);
  const [selectedIndex, setSelectedIndex] = useState(-1);
  const searchRef = useRef(null);
  const navigate = useNavigate();

  useEffect(() => {
    const timer = setTimeout(() => {
      if (query.length >= 2) {
        handleSearch(query);
      } else {
        setResults([]);
        setShowDropdown(false);
      }
    }, 300);
    return () => clearTimeout(timer);
  }, [query]);

  useEffect(() => {
    const handleClickOutside = (event) => {
      if (searchRef.current && !searchRef.current.contains(event.target)) {
        setShowDropdown(false);
      }
    };
    document.addEventListener('mousedown', handleClickOutside);
    return () => document.removeEventListener('mousedown', handleClickOutside);
  }, []);

  const handleSearch = async (searchQuery) => {
    setLoading(true);
    try {
      const data = await companyService.searchAutocomplete(searchQuery, 10);
      setResults(data);
      setShowDropdown(true);
      setSelectedIndex(-1);
    } catch (error) {
      console.error('Error searching companies:', error);
      setResults([]);
    } finally {
      setLoading(false);
    }
  };

  const handleSelectCompany = (company) => {
    setQuery('');
    setShowDropdown(false);
    navigate(`/companies/${company.slug}`);
  };

  const handleKeyDown = (e) => {
    if (!showDropdown || results.length === 0) return;
    switch (e.key) {
      case 'ArrowDown':
        e.preventDefault();
        setSelectedIndex((prev) => (prev < results.length - 1 ? prev + 1 : prev));
        break;
      case 'ArrowUp':
        e.preventDefault();
        setSelectedIndex((prev) => (prev > 0 ? prev - 1 : -1));
        break;
      case 'Enter':
        e.preventDefault();
        if (selectedIndex >= 0 && selectedIndex < results.length) {
          handleSelectCompany(results[selectedIndex]);
        }
        break;
      case 'Escape':
        setShowDropdown(false);
        setSelectedIndex(-1);
        break;
      default:
        break;
    }
  };

  const isDark = variant === 'dark';

  return (
    <div className={`relative w-full ${isDark ? 'max-w-md' : ''}`} ref={searchRef}>
      <div className="relative">
        <input
          type="text"
          placeholder={placeholder}
          className={
            isDark
              ? 'text-white placeholder-white/60 border-2 border-white/70 rounded-xl w-full pr-14 bg-white/10 backdrop-blur-sm focus:outline-none focus:border-white focus:bg-white/15 px-5 py-4 text-base sm:text-lg transition-all'
              : 'text-gray-900 placeholder-gray-400 border border-gray-200 rounded-full w-full pr-10 bg-white focus:outline-none focus:ring-2 focus:ring-red-400 focus:border-transparent px-4 py-2 text-sm transition-all'
          }
          value={query}
          onChange={(e) => setQuery(e.target.value)}
          onKeyDown={handleKeyDown}
          onFocus={() => { if (results.length > 0) setShowDropdown(true); }}
        />

        {isDark ? (
          <span className="absolute inset-y-0 right-0 pr-2 flex items-center pointer-events-none">
            <Search className="text-white bg-red-600 rounded-full p-2" size={40} />
          </span>
        ) : (
          <span className="absolute inset-y-0 right-3 flex items-center pointer-events-none">
            <Search size={15} className={loading ? 'text-red-400' : 'text-gray-400'} />
          </span>
        )}
      </div>

      {showDropdown && (
        <div className="absolute z-50 w-full mt-2 bg-white rounded-2xl shadow-2xl border border-gray-100 max-h-96 overflow-y-auto">
          {loading ? (
            <div className="p-4 text-center text-gray-400 text-sm">Recherche en cours…</div>
          ) : results.length > 0 ? (
            <ul className="py-1.5">
              {results.map((company, index) => (
                <li
                  key={company.id}
                  className={`px-4 py-3 cursor-pointer transition-colors ${
                    index === selectedIndex ? 'bg-red-50' : 'hover:bg-gray-50'
                  }`}
                  onClick={() => handleSelectCompany(company)}
                  onMouseEnter={() => setSelectedIndex(index)}
                >
                  <div className="flex items-center gap-3">
                    {company.imageUrl ? (
                      <img src={company.imageUrl} alt={company.name} className="w-10 h-10 object-cover rounded-xl shrink-0" />
                    ) : (
                      <div className="w-10 h-10 bg-red-100 rounded-xl flex items-center justify-center shrink-0">
                        <span className="text-red-500 font-bold text-sm">{company.name?.[0]}</span>
                      </div>
                    )}
                    <div className="flex-1 min-w-0">
                      <p className="font-semibold text-gray-900 text-sm truncate">{company.name}</p>
                      <p className="text-xs text-gray-400 flex items-center gap-1 mt-0.5">
                        <MapPin size={10} />
                        {company.ville || company.adresse || 'Sénégal'}
                      </p>
                      {company.category && (
                        <p className="text-xs text-red-500 font-medium mt-0.5">{company.category.name}</p>
                      )}
                    </div>
                    {company.averageRating > 0 && (
                      <div className="flex items-center gap-0.5 shrink-0">
                        {[...Array(5)].map((_, i) => (
                          <Star
                            key={i}
                            size={10}
                            className={i < Math.round(company.averageRating) ? 'fill-red-500 text-red-500' : 'fill-gray-200 text-gray-200'}
                          />
                        ))}
                      </div>
                    )}
                  </div>
                </li>
              ))}
            </ul>
          ) : (
            <div className="p-4 text-center text-gray-400 text-sm">Aucun résultat trouvé</div>
          )}
        </div>
      )}
    </div>
  );
};

export default SearchAutocomplete;
