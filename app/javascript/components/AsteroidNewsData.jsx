import React from 'react'
import ReactDOM from 'react-dom'
import PropTypes from 'prop-types'

class AsteroidNewsData extends React.Component {
  constructor(props) {
    super(props);
    this.onSuccessApi = this.onSuccessApi.bind(this);
    this.onFailureApi = this.onFailureApi.bind(this);
    this.renderSuccessResponse = this.renderSuccessResponse.bind(this);
    this.renderFailureResponse = this.renderFailureResponse.bind(this);
    this.state = {
      asteroidNewsDataVisible: false,
      hasErrored: false,
      asteroid_count: null,
      asteroids: null,
      asteroid_image: null
    }
  }

  onSuccessApi(obj) {
    this.setState( 
      {
        asteroidNewsDataVisible: true,
        hasErrored: false,
        asteroid_count: obj['element_count'],
        asteroids: obj['near_earth_objects'],
        asteroid_image: obj['asteroid_image']
      }
    )
  }

  onFailureApi(error) {
    this.setState(
        {
        asteroidNewsDataVisible: false,
        hasErrored: true
        }
    )
    console.log(error);
  }

  isAsteroidHazardous(data) {
    if(data) {
        return(
           <span><b> Yes </b></span>
        )
    } else {
        return(
           <span><b> No </b></span>
        )
    }
  }

  renderSuccessResponse(isVisible) {
    const asteroid_objects = this.state.asteroids
    if(isVisible) {
      return (
        <div className="card-body">
          <h5 className="card-title"> Asteroids that flew by Earth today! </h5>
          <p className="card-title">Number of close encounters: <span><b>{this.state.asteroid_count}</b></span></p>
          <button type="button" className="btn btn-outline-dark" data-toggle="modal" data-target="#exampleModal1" style={{position: "absolute", right: 0, bottom: 0, marginRight: "3px", marginBottom: "3px"}}>
            More!
          </button>
          <div className="modal fade" id="exampleModal1" tabIndex="-1" role="dialog" aria-labelledby="exampleModalLabel1" aria-hidden="true">
            <div className="modal-dialog" role="document">
              {
                asteroid_objects.map((value, index) => {
                    return (
                        <div key={index}>
                            <div className="modal-content">
                                <div className="modal-header">
                                    <h5 className="modal-title" id="exampleModalLabel">Comet Name:  {value['name']}</h5>
                                </div>
                                <div className="modal-body">
                                    <p className="card-text">Minimum Diameter (in Km): <span><b>{value['estimated_diameter']['kilometers']['estimated_diameter_min']}</b></span></p>
                                    <p className="card-text">Maximum Diameter (in Km): <span><b>{value['estimated_diameter']['kilometers']['estimated_diameter_max']}</b></span></p>
                                    <p className="card-text">Is it hazardous: {this.isAsteroidHazardous(value['is_potentially_hazardous_asteroid'])}</p>
                                    <p className="card-text">Closest approach to Earch (in Km): <span><b>{value['close_approach_data'].pop()['miss_distance']['kilometers']}</b></span></p>
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
      <div className="card-body">
        <h3 className="card-title">Data not available temporarily</h3>
      </div>
    )
  }

  renderAsteroidNewsData(asteroidDataUrl) {
    fetch(asteroidDataUrl, {headers: {'Content-Type': 'application/json',Accept: 'application/json'}})
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
    this.renderAsteroidNewsData(this.props.asteroidDataUrl);
  }

  render() {
    const isVisible = this.state.asteroidNewsDataVisible;
    const hasApiErrored = this.state.hasErrored;
    let asteroidNewsData;
    if(!hasApiErrored) {
      asteroidNewsData = this.renderSuccessResponse(isVisible);
    } else {
      asteroidNewsData = this.renderFailureResponse();
    }
    return (
      <div>
        <img src={this.state.asteroid_image} alt="AsteroidImage" className="card-img-top card-details"/>
        {asteroidNewsData}
      </div>
    );
  }
}
export default AsteroidNewsData;