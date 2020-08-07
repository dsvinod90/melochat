import React from 'react'
// import ReactDOM from 'react-dom'
// import PropTypes from 'prop-types'

class HelloWorld extends React.Component {
  constructor(props) {
    super(props);
  }

  render() {
    return (
      <div>
        <h1>Hello!, {this.props.name}</h1>
      </div>
    );
  }
}
export default HelloWorld;