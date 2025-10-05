import React, { useState } from 'react';
import { X, Upload, CheckCircle, AlertCircle, Store } from 'lucide-react';
import { useAuth } from '../../context/AuthContext';
import { sellerApplicationsAPI } from '../../utils/api';
import './BecomeSellerModal.css';

const BecomeSellerModal = ({ isOpen, onClose }) => {
  const { user, updateUser } = useAuth();
  const [formData, setFormData] = useState({
    businessName: '',
    businessType: '',
    description: '',
    address: '',
    city: '',
    state: '',
    pincode: '',
    gstNumber: '',
    bankAccount: '',
    ifscCode: '',
  });
  const [error, setError] = useState('');
  const [success, setSuccess] = useState(false);
  const [loading, setLoading] = useState(false);

  if (!isOpen) return null;

  const handleChange = (e) => {
    const { name, value } = e.target;
    setFormData({
      ...formData,
      [name]: value,
    });
    setError('');
  };

  const handleSubmit = async (e) => {
    e.preventDefault();
    setError('');
    setLoading(true);

    // Check if user is authenticated
    if (!user) {
      setError('Please log in to submit a seller application.');
      setLoading(false);
      return;
    }

    // Check if user has a valid token
    const token = localStorage.getItem('token');
    if (!token || token === 'offline-token') {
      setError('Your session is invalid. Please log out and log in again.');
      setLoading(false);
      return;
    }

    // Basic token validation (JWT has 3 parts)
    if (token.split('.').length !== 3) {
      setError('Your session token is invalid. Please log out and log in again.');
      setLoading(false);
      return;
    }

    // Validation
    if (!formData.businessName || !formData.businessType || !formData.address || 
        !formData.city || !formData.state || !formData.pincode || !formData.description) {
      setError('Please fill in all required fields');
      setLoading(false);
      return;
    }

    try {
      // Submit seller application via API
      const response = await sellerApplicationsAPI.submit({
        businessName: formData.businessName,
        businessType: formData.businessType,
        description: formData.description,
        address: formData.address,
        city: formData.city,
        state: formData.state,
        pincode: formData.pincode,
        gstNumber: formData.gstNumber || '',
        bankAccount: formData.bankAccount || '',
        ifscCode: formData.ifscCode || ''
      });

      if (response.success) {
        setSuccess(true);
        
        setTimeout(() => {
          onClose();
          setSuccess(false);
          setFormData({
            businessName: '',
            businessType: '',
            description: '',
            address: '',
            city: '',
            state: '',
            pincode: '',
            gstNumber: '',
            bankAccount: '',
            ifscCode: '',
          });
        }, 2000);
      } else {
        // Handle validation errors or other error messages
        let errorMessage = response.message || 'Failed to submit application';
        if (response.errors && Array.isArray(response.errors)) {
          errorMessage = response.errors.map(err => err.msg || err.message).join(', ');
        }
        setError(errorMessage);
        setLoading(false);
      }
    } catch (err) {
      console.error('Submit application error:', err);
      // Provide more detailed error messages
      let errorMessage = 'Failed to submit application. Please try again.';
      
      // Check if error has validation errors from backend
      if (err.errors && Array.isArray(err.errors)) {
        errorMessage = err.errors.map(e => e.msg || e.message || e).join(', ');
      } else if (err.data) {
        // Use error data from API response
        if (err.data.errors && Array.isArray(err.data.errors)) {
          errorMessage = err.data.errors.map(e => e.msg || e.message || e).join(', ');
        } else if (err.data.message) {
          errorMessage = err.data.message;
        }
      } else if (err.message) {
        if (err.requiresAuth || err.status === 401 || err.message.includes('Unauthorized') || err.message.includes('invalid') || err.message.includes('expired')) {
          errorMessage = 'Your session has expired or is invalid. Please log out and log in again to submit an application.';
        } else if (err.isNetworkError || err.message.includes('fetch') || err.message.includes('Network')) {
          errorMessage = 'Unable to connect to server. Please check if the backend server is running on http://localhost:3000 and try again.';
        } else if (err.status === 403 || err.message.includes('Forbidden')) {
          errorMessage = 'You do not have permission to perform this action.';
        } else if (err.status === 400 || err.message.includes('Bad Request')) {
          errorMessage = err.message || 'Invalid data provided. Please check all fields.';
        } else {
          errorMessage = err.message;
        }
      }
      
      setError(errorMessage);
      setLoading(false);
    }
  };

  return (
    <div className="seller-modal-overlay" onClick={onClose}>
      <div className="seller-modal-content" onClick={(e) => e.stopPropagation()}>
        <div className="seller-modal-header">
          <div className="seller-modal-title">
            <Store size={24} />
            <h2>Become a Seller</h2>
          </div>
          <button className="seller-modal-close" onClick={onClose}>
            <X size={20} />
          </button>
        </div>

        {success ? (
          <div className="seller-modal-success">
            <CheckCircle size={48} />
            <h3>Registration Submitted!</h3>
            <p>Your seller application has been submitted successfully. We'll review it and get back to you soon.</p>
          </div>
        ) : (
          <form className="seller-modal-form" onSubmit={handleSubmit}>
            {error && (
              <div className="seller-form-error">
                <AlertCircle size={18} />
                <span>{error}</span>
              </div>
            )}

            <div className="seller-form-group">
              <label>
                Business Name <span className="required">*</span>
              </label>
              <input
                type="text"
                name="businessName"
                value={formData.businessName}
                onChange={handleChange}
                placeholder="Enter your business name"
                required
              />
            </div>

            <div className="seller-form-group">
              <label>
                Business Type <span className="required">*</span>
              </label>
              <select
                name="businessType"
                value={formData.businessType}
                onChange={handleChange}
                required
              >
                <option value="">Select business type</option>
                <option value="handicrafts">Handicrafts</option>
                <option value="textiles">Textiles & Clothing</option>
                <option value="jewelry">Jewelry</option>
                <option value="food">Food & Spices</option>
                <option value="beauty">Beauty & Wellness</option>
                <option value="art">Art & Decor</option>
                <option value="other">Other</option>
              </select>
            </div>

            <div className="seller-form-group">
              <label>Business Description</label>
              <textarea
                name="description"
                value={formData.description}
                onChange={handleChange}
                placeholder="Describe your products and business..."
                rows="4"
              />
            </div>

            <div className="seller-form-group">
              <label>
                Business Address <span className="required">*</span>
              </label>
              <textarea
                name="address"
                value={formData.address}
                onChange={handleChange}
                placeholder="Street address, building name"
                rows="2"
                required
              />
            </div>

            <div className="seller-form-row">
              <div className="seller-form-group">
                <label>
                  City <span className="required">*</span>
                </label>
                <input
                  type="text"
                  name="city"
                  value={formData.city}
                  onChange={handleChange}
                  placeholder="City"
                  required
                />
              </div>

              <div className="seller-form-group">
                <label>
                  State <span className="required">*</span>
                </label>
                <input
                  type="text"
                  name="state"
                  value={formData.state}
                  onChange={handleChange}
                  placeholder="State"
                  required
                />
              </div>

              <div className="seller-form-group">
                <label>
                  Pincode <span className="required">*</span>
                </label>
                <input
                  type="text"
                  name="pincode"
                  value={formData.pincode}
                  onChange={handleChange}
                  placeholder="Pincode"
                  required
                />
              </div>
            </div>

            <div className="seller-form-row">
              <div className="seller-form-group">
                <label>GST Number (Optional)</label>
                <input
                  type="text"
                  name="gstNumber"
                  value={formData.gstNumber}
                  onChange={handleChange}
                  placeholder="GSTIN"
                />
              </div>

              <div className="seller-form-group">
                <label>Bank Account Number (Optional)</label>
                <input
                  type="text"
                  name="bankAccount"
                  value={formData.bankAccount}
                  onChange={handleChange}
                  placeholder="Account number"
                />
              </div>
            </div>

            <div className="seller-form-group">
              <label>IFSC Code (Optional)</label>
              <input
                type="text"
                name="ifscCode"
                value={formData.ifscCode}
                onChange={handleChange}
                placeholder="IFSC code"
              />
            </div>

            <div className="seller-modal-footer">
              <button type="button" className="btn btn-outline" onClick={onClose}>
                Cancel
              </button>
              <button type="submit" className="btn btn-primary" disabled={loading}>
                {loading ? 'Submitting...' : 'Submit Application'}
              </button>
            </div>
          </form>
        )}
      </div>
    </div>
  );
};

export default BecomeSellerModal;

