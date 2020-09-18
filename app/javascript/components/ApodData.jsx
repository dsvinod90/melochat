import React from 'react'
import ReactDOM from 'react-dom'
import PropTypes from 'prop-types'

class ApodData extends React.Component {
  constructor(props) {
    super(props);
    this.onSuccessApi = this.onSuccessApi.bind(this);
    this.onFailureApi = this.onFailureApi.bind(this);
    this.renderSuccessResponse = this.renderSuccessResponse.bind(this);
    this.renderFailureResponse = this.renderFailureResponse.bind(this);
    this.state = {
      apodDataVisible: false,
      hasErrored: false,
      description: null,
      image: null,
      title: null,
      date: null
    }
  }

  onSuccessApi(obj) {
    this.setState(
      {
        apodDataVisible: true,
        hasErrored: false,
        description: obj['explanation'],
        image: obj['url'],
        title: obj['title'],
        date: obj['date']
      }
    )
  }

  onFailureApi(error) {
    console.log(error);
    this.setState(
      {
        apodDataVisible: false,
        hasErrored: true,
      }
    )
  }

  renderSuccessResponse(isVisible) {
    if(isVisible) {
      return (
        <div className="card-body">
          <h5 className="card-text">{this.state.title}</h5>
          <p className="card-text">{this.state.description}</p>
          <p className="card-text"><small className="text-muted">Date: {this.state.date}</small></p>
        </div>
      )
    } else {
      return(
        <div>
           <p>Loading...</p>
        </div>
      )
    }
  }

  renderFailureResponse() {
    return(
      <div>
        <h3 className="card-text">Data not available temporarily</h3>
      </div>
    )
  }

  renderApodData(apodDataUrl) {
    fetch(apodDataUrl, {headers: {'Content-Type': 'application/json',Accept: 'application/json'}})
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

  componentDidMount() {
    this.renderApodData(this.props.apodDataUrl);
  }

  render() {
    const isVisible = this.state.apodDataVisible;
    const hasApiErrored = this.state.hasErrored;
    let apodData;
    if(!hasApiErrored) {
      apodData = this.renderSuccessResponse(isVisible);
    } else {
      apodData = this.renderFailureResponse();
    }
    return (
      <div className="card mb-3">
        <img src={this.state.image} alt="ApodImage" className="card-img-top"/>
        {apodData}
      </div>
    );
  }
}
export default ApodData;
