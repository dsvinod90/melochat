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
        <div className="card-body justify-content-center">
          <p className="card-text text-center">Number of close encounters: <span><b>{this.state.asteroid_count}</b></span></p>
          <table className="table table-hover table-dark">
            <thead>
              <tr>
                <th scope="col">Comet Name</th>
                <th scope="col">Min Diameter(Km)</th>
                <th scope="col">Max Diameter(Km)</th>
                <th scope="col">Hazardous?</th>
                <th scope="col">Closest to Earth(Km)</th>
              </tr>
            </thead>
            <tbody>
              {
                asteroid_objects.map((value, index) => {
                  return (
                    <tr key={index}>
                      <td>{value['name']}</td>
                      <td>{value['estimated_diameter']['kilometers']['estimated_diameter_min']}</td>
                      <td>{value['estimated_diameter']['kilometers']['estimated_diameter_max']}</td>
                      <td>{this.isAsteroidHazardous(value['is_potentially_hazardous_asteroid'])}</td>
                      <td>{value['close_approach_data'].pop()['miss_distance']['kilometers']}</td>
                    </tr>
                  )
                }
              )}
            </tbody>
          </table>
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
      <div className="card mb-3">
        <img src={this.state.asteroid_image} alt="AsteroidImage" className="card-img-top"/>
        {asteroidNewsData}
      </div>
    );
  }
}
export default AsteroidNewsData;
