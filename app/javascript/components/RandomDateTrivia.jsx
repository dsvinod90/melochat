import React from 'react'
import ReactDOM from 'react-dom'
import PropTypes from 'prop-types'

class RandomDateTrivia extends React.Component {
  constructor(props) {
    super(props);
    this.renderTrivia = this.renderTrivia.bind(this);
    this.onSuccessApi = this.onSuccessApi.bind(this);
    this.onFailureApi = this.onFailureApi.bind(this);
    this.state = {
      trivia: null
    }
  }

  onSuccessApi(obj) {
    this.setState(
      {
        trivia: obj['trivia']
      }
    )
  }

  onFailureApi(error) {
    console.log(error)
    this.setState(
      {
        trivia: 'Data not available'
      }
    )
  }

  renderTrivia(randomDateTriviaUrl) {
    fetch(randomDateTriviaUrl, {headers: {'Content-Type': 'application/json',Accept: 'application/json'}})
    .then(
      response => {
        if (response.status >= 200 && response.status <= 299) {
          return response.json();
        } else {
          throw Error(response.statusText);
        }
      }
    )
    .then(data => { this.onSuccessApi(data); })
    .catch(error => { this.onFailureApi(error); })
  }

  render() {
    return(
      <div style={{marginLeft: "10px"}}>
        <p style={{paddingTop: "20px"}}>
          <button type="button" className="btn btn-outline-dark" data-toggle="modal" data-target="#exampleModal5"  onClick={() => this.renderTrivia(this.props.randomDateTriviaUrl)}>
            Random Date Trivia
          </button>
        </p>
        <div className="modal fade" id="exampleModal5" tabIndex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
          <div className="modal-dialog" role="document">
            <div className="modal-content">
              <div className="modal-header">
                <h5 className="modal-title" id="exampleModalLabel">Random Date Trivia</h5>
              </div>
              <div className="modal-body">
                {this.state.trivia}
              </div>
            </div>
          </div>
        </div>
      </div>
    )
  }
}
export default RandomDateTrivia;