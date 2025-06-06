// renderer/src/UpdateWorkshop.jsx
import { useEffect, useState } from 'react'
import { useLocation } from 'react-router-dom'
import { Link } from 'react-router-dom'

export default function UpdateWorkshop() {
  useEffect(() => {
    document.title = 'Редактировать цех'
  }, [])

  const location = useLocation()
  // В location.state.workshop мы ожидаем объект { id, name, workshop_type, workers_count }
  const [workshop, setWorkshop] = useState(location.state.workshop)

  async function submitHandler(e) {
    e.preventDefault()
    const upd = {
      id: workshop.id,
      name: e.target.name.value,
      workshop_type: e.target.type.value,
      workers_count: Number(e.target.workers_count.value)
    }
    await window.api.updateWorkshop(upd)
    setWorkshop(upd)
    document.querySelector('form').reset()
  }

  return (
    <div className="form">
      <Link to={'/'}>
        <button>{"<-- Назад"}</button>
      </Link>
      <h1>Редактировать цех</h1>
      <form onSubmit={(e) => submitHandler(e)}>
        <label htmlFor="name">Название цеха:</label>
        <input
          id="name"
          type="text"
          required
          defaultValue={workshop.name}
        />

        <label htmlFor="type">Тип цеха:</label>
        <select id="type" required defaultValue={workshop.workshop_type}>
          <option value="Проектирование">Проектирование</option>
          <option value="Обработка">Обработка</option>
          <option value="Сушка">Сушка</option>
          <option value="Сборка">Сборка</option>
        </select>

        <label htmlFor="workers_count">Количество человек:</label>
        <input
          id="workers_count"
          type="number"
          min="1"
          step="1"
          required
          defaultValue={workshop.workers_count}
        />

        <button type="submit">Обновить цех</button>
      </form>
    </div>
  )
}
