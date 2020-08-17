import React from 'react'
import ReactDOM from 'react-dom'
import PropTypes from 'prop-types'

class Astronauts extends React.Component {
  constructor(props) {
    super(props);
    this.onSuccessApi = this.onSuccessApi.bind(this);
    this.onFailureApi = this.onFailureApi.bind(this);
    this.renderSuccessResponse = this.renderSuccessResponse.bind(this);
    this.renderFailureResponse = this.renderFailureResponse.bind(this);
    this.state = {
      astronautDataVisible: false,
      numberOfAstronauts: null,
      people: null,
      astronaut_image: null
    }
  }

  onSuccessApi(obj) {
    this.setState( 
      {
        astronautDataVisible: true,
        numberOfAstronauts: obj['astronaut_data']['number'],
        people: obj['astronaut_data']['people'],
        astronaut_image: obj['astronaut_image']
      }
    )
  }

  onFailureApi(error) {
    console.log(error);
    this.setState( 
      {
        astronautDataVisible: false
      }
    )
  }

  renderSuccessResponse() {
    const astronauts = this.state.people;
    return (
      <div className="card-body">
        <h5 className="card-title"> Astronauts in space now! </h5>
        <p className="card-title">There are <span><b>{this.state.numberOfAstronauts}</b></span> astronauts in space at this moment.</p>
        <a data-toggle="modal" href="#exampleModal3" style={{position: "absolute", right: 0, bottom: 0, marginRight: "3px", marginBottom: "3px"}}>
          Read More!
        </a>
        <div className="modal fade" id="exampleModal3" tabIndex="-1" role="dialog" aria-labelledby="exampleModalLabel3" aria-hidden="true">
          <div className="modal-dialog" role="document">
            {
              astronauts.map((value, index) => {
                  return (
                      <div key={index}>
                        <div className="modal-content">
                          <div className="modal-header">
                            <button type="button" className="close" data-dismiss="modal" aria-label="Close">
                              <span aria-hidden="true">X</span>
                            </button>
                          </div>
                          <div className="modal-body">
                              <p className="card-text">Name: <span><b>{value['name']}</b></span></p>
                              <p className="card-text">Craft: <span><b>{value['craft']}</b></span></p>
                          </div>
                        </div>
                      </div>
                  )
              })
            }
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

  renderAstronautData(astronautDataUrl) {
    fetch(astronautDataUrl, {headers: {'Content-Type': 'application/json',Accept: 'application/json'}})
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
    this.renderAstronautData(this.props.astronautDataUrl);
  }

  render() {
    const isVisible = this.state.astronautDataVisible;
    let astronautData;
    if(isVisible) {
      astronautData = this.renderSuccessResponse();
    } else {
      astronautData = this.renderFailureResponse();
    }
    return (
      <div>
        <img src={this.state.astronaut_image} alt="AsteroidImage" className="card-img-top card-details"/>
        {astronautData}
      </div>
    );
  }
}
export default Astronauts;
