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
        description: obj['explanation'],
        image: obj['url'],
        title: obj['title'],
        date: obj['date']
      }
    )
  }

  onFailureApi(error) {
    console.log(error);
  }

  renderSuccessResponse() {
    return (
      <div className="card-body">
        <h5 className="card-title"> Space article of the day! </h5>
        <p className="card-title">{this.state.title}</p>
        <button type="button" className="btn btn-primary" data-toggle="modal" data-target="#exampleModal">
          Read More
        </button>
        <div className="modal fade" id="exampleModal" tabIndex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
          <div className="modal-dialog" role="document">
            <div className="modal-content">
              <div className="modal-header">
                <h5 className="modal-title" id="exampleModalLabel">{this.state.title}</h5>
              </div>
              <div className="modal-body">
                <img src={this.state.image} alt="ApodImage" className="card-img-top card-details"/>
                <p className="card-text">{this.state.description}</p>
                <p className="card-text"><small className="text-muted">Date: {this.state.date}</small></p>
              </div>
              <div className="modal-footer">
                <button type="button" className="btn btn-secondary" data-dismiss="modal">Close</button>
              </div>
            </div>
          </div>
        </div>
      </div>
    )
  }

  renderFailureResponse() {
    return(
      <div className="card-body">
        <h3 className="card-title">Data not available temporarily</h3>
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
    let apodData;
    if(isVisible) {
      apodData = this.renderSuccessResponse();
    } else {
      apodData = this.renderFailureResponse();
    }
    return (
      <div>
        <img src={this.state.image} alt="ApodImage" className="card-img-top card-details"/>
        {apodData}
      </div>
    );
  }
}
export default ApodData;