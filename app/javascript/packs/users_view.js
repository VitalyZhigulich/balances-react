import React, { useState, useEffect } from 'react'
import UsersChannel from 'channels/users_channel'

const UsersView = () => {
  const [usersById, setUsersById] = useState({})

  useEffect(() => {
    UsersChannel.received = (data) => {
      const mergedUsersById = { ...usersById, ...data.users }

      setUsersById(mergedUsersById)
    }
  }, [])

  if (Object.keys(usersById).length === 0) {
    return <p>There are no items to display</p>
  }

  return (
    <table>
      <thead>
        <tr>
          <td>Email</td>
          <td>Balance</td>
        </tr>
      </thead>
      <tbody>
        {Object.entries(usersById).map(([id, user]) => (
          <tr key={id}>
            <td>{user.email}</td>
            <td>{user.balance}</td>
          </tr>
        ))}
      </tbody>
    </table>
  )
}

export default UsersView;
