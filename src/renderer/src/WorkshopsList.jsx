// renderer/src/App.jsx
import { useEffect, useState } from "react"
import { Link } from "react-router-dom"
import { useNavigate } from "react-router-dom"
import logo from "./assets/logo.png"

function App() {
  const navigate = useNavigate()
  const [workshops, setWorkshops] = useState([])

  useEffect(() => {
    (async () => {
      const res = await window.api.getWorkshops()
      setWorkshops(res)
    })()
  }, [])

  return (
    <>
      <div className="page-heading">
        <img className="page-logo" src={logo} alt="" />
        <h1>Цеха</h1>
      </div>

      <ul className="partners-list">
        {workshops.map((w) => {
          return (
            <li
              className="partner-card"
              key={w.id}
              onClick={() => {
                navigate("/update", { state: { workshop: w } })
              }}
            >
              <div className="partner-data">
                <p className="card_heading">
                  {w.workshop_type} | {w.name}
                </p>
                <div className="partner-data-info">
                  <p>Работников: {w.workers_count}</p>
                </div>
              </div>
              <div className="partner-sale partner-data card_heading">
                ID: {w.id}
              </div>
            </li>
          )
        })}
      </ul>

      <Link to={"/create"}>
        <button>Создать цех</button>
      </Link>
    </>
  )
}

export default App
