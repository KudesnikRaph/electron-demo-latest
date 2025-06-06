// renderer/src/main.jsx
import './styles.css'
import { StrictMode } from 'react'
import { createRoot } from 'react-dom/client'
import { Routes, Route, HashRouter } from 'react-router-dom'
import WorkshopsList from './WorkshopsList.jsx'
import CreateWorkshop from './CreateWorkshop.jsx'
import UpdateWorkshop from './UpdateWorkshop.jsx'

createRoot(document.getElementById('root')).render(
  <HashRouter>
    <StrictMode>
      <Routes>
        <Route path="/" element={<WorkshopsList />} />
        <Route path="/create" element={<CreateWorkshop />} />
        <Route path="/update" element={<UpdateWorkshop />} />
      </Routes>
    </StrictMode>
  </HashRouter>
)
