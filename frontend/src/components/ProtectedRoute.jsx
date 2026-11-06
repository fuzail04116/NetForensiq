// SPDX-License-Identifier: MIT
// Copyright (c) 2026 A Muhammed Fuzail — NetForensiq (https://github.com/fuzail04116/NetForensiq)
import { Navigate, useLocation } from 'react-router-dom';
import { isAuthenticated, getCurrentUser } from '../services/auth';

function ProtectedRoute({ children, allowedRoles }) {
  const location = useLocation();

  if (!isAuthenticated()) {
    return <Navigate to="/login" state={{ from: location }} replace />;
  }

  if (allowedRoles) {
    const user = getCurrentUser();
    if (!user || !allowedRoles.includes(user.role)) {
      return <Navigate to="/dashboard" replace />;
    }
  }

  return children;
}

export default ProtectedRoute;